import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:riverpod/riverpod.dart';
import 'package:translation_gen/data/database.dart';
import 'package:translation_gen/service/files_service.dart';
import 'package:translation_gen/service/logger_service.dart';
import 'package:translation_gen/service/open_ai_service.dart';
import 'package:translation_gen/string_extension.dart';

class AppSetupService {
  late Database appDatabase;
  final LoggerService _loggerService = LoggerService();
  final OpenAiService _openAiService = OpenAiService();
  final FilesService _filesService = FilesService();

  AppSetupService() {
    final container = ProviderContainer();

    appDatabase = container.read(dbProviderLocal);

    appDatabase.customStatement("PRAGMA synchronous = OFF");
    appDatabase.customStatement("PRAGMA journal_mode = MEMORY");
  }
  Future<String?> setup({
    required String appName,
    required String language,
    required List<String> entries,
  }) async {
    _loggerService.info('Setting up App...');

    final app = await appDatabase.getAppByName(appName).getSingleOrNull();
    if (app != null) {
      await _validateFileAndLangSetups(
        appName: appName,
        language: language,
        entries: entries,
      );
      await _setupEntries(entries, appName, language);

      final langCode =
          await _setUpLanguages(appName: appName, language: language);
      //
      final appGenerated =
          await appDatabase.getAppGenerated(appName).getSingleOrNull();
      if (appGenerated == null) {
        await _setupFiles(appName: appName);
        await appDatabase.setAppGenerated(appName);
        _loggerService.info('App Setup Done');
      } else {
        _loggerService.info('App Already Setup, aborting...');
      }
      return langCode;
    } else {
      // creates the app, recall setup();
      await _setUpApp(appName);
      return await setup(
          appName: appName, language: language, entries: entries);
    }
  }

  _setUpApp(String appName) async {
    try {
      _loggerService.info('Setting up App...');
      await appDatabase.apps.insertOne(
        App(name: appName, version: 1, appGenerated: 0),
        mode: InsertMode.insertOrAbort,
      );
    } catch (e) {
      _loggerService.info('App Exist, aborting...\nusing existing App');
    }
  }

  _setupEntries(
    List<String> entries,
    String appName,
    String languageTo, {
    String languageFrom = 'english',
  }) async {
    try {
      final app = await appDatabase.getAppByName(appName).getSingleOrNull();
      if (app != null) {
        print('Setting Up all Sentence Entries...');
        await appDatabase.entries.insertAll(
          entries.map(
            (e) => SentenceEntry(
              entryId:
                  '${e.toTranslateKey()}_${appName}_${languageFrom}_$languageTo',
              entryKey: e.toTranslateKey(),
              entryTranslationFrom: e,
              appName: appName,
              entryLanguageTo: languageTo,
              entryLanguageFrom: languageFrom,
              entryGenerated: 0,
            ),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      } else {
        print('App not found, creating...');
        await _setUpApp(appName);
        await _setupEntries(entries, appName, languageTo);
      }
    } catch (e, t) {
      _loggerService.error(e, e, t);
    }
  }

  Future<String> _setUpLanguages(
      {required String appName, required String language}) async {
    String languageCode = '';
    try {
      final globalLanguage = await appDatabase
          .getLanguageFromGlobalIndex(language)
          .getSingleOrNull();
      if (globalLanguage == null) {
        final languageCodeRes = await _openAiService.getLanguageCode(language);
        languageCode = languageCodeRes.split('-')[0].trim().replaceAll(' ', '');
        print('CODE $languageCode');

        await appDatabase.globalLanguages.insertOne(
          GlobalLanguage(language: language, code: languageCode),
          mode: InsertMode.insertOrIgnore,
        );
        _loggerService
            .info('Added new language [$language] to global languages');
        final app = await appDatabase.getAppByName(appName).getSingleOrNull();
        if (app != null) {
          await appDatabase.appLanguages.insertOne(
            AppLanguage(
              appName: appName,
              language: language,
              languageCode: languageCode,
            ),
            mode: InsertMode.insertOrIgnore,
          );
          _loggerService.info('Added new language [$language] to App $appName');
        }
      } else {
        final app = await appDatabase.getAppByName(appName).getSingleOrNull();
        if (app != null) {
          await appDatabase.appLanguages.insertOne(
            AppLanguage(
              appName: appName,
              language: language,
              languageCode: globalLanguage.code,
            ),
            mode: InsertMode.insertOrIgnore,
          );
          _loggerService.info('Added new language [$language] to App $appName');
        }
      }
      return languageCode.isNotEmpty
          ? languageCode
          : globalLanguage?.code ?? languageCode;
    } catch (e) {
      _loggerService.error('Failed to setup languages', e);
      rethrow;
    }
  }

  _validateFileAndLangSetups(
      {required String appName,
      required String language,
      required List<String> entries}) async {
    final appLanguage =
        await appDatabase.getAppLanguage(appName, language).getSingleOrNull();
    if (appLanguage != null) {
      //app language exists in DB so check if files exist and is valid formart (en, $language)
      final isEnglishFileSet =
          await _filesService.validateFile(appName: appName);
      final isTranslatedFilSet = await _filesService.validateFile(
          appName: appName, locale: appLanguage.languageCode);
      if (!isTranslatedFilSet || !isEnglishFileSet) {
        // files are not valid  unset app
        await appDatabase.unsetAppGenerated(appName);
        await _setupFiles(appName: appName);
        await setup(appName: appName, language: language, entries: entries);
      }
    } else {
      // app language does not exist in DB so unset app
      await appDatabase.unsetAppGenerated(appName);
      await _setUpLanguages(appName: appName, language: language);
      await _setupFiles(appName: appName);
      await setup(appName: appName, language: language, entries: entries);
    }
  }

  _setupFiles({required String appName}) async {
    try {
      final appLanguages =
          await appDatabase.getLanguagesByAppName(appName).get();
      final isEnglishFileSet =
          await _filesService.validateFile(appName: appName);
      if (!isEnglishFileSet) {
        final String englishFilePath =
            _filesService.createFileIfNotExists(appName: appName);
        await _setupFile(filePath: englishFilePath, locale: 'en');
      }

      for (var appLanguage in appLanguages) {
        final isTranslationFilesSet = await _filesService.validateFile(
          appName: appName,
          locale: appLanguage.languageCode,
        );
        if (!isTranslationFilesSet) {
          final String translatedFilePath = _filesService.createFileIfNotExists(
            appName: appName,
            locale: appLanguage.languageCode,
          );
          await _setupFile(
              filePath: translatedFilePath, locale: appLanguage.languageCode);
          print('settig up ${appLanguage.languageCode} file');
        }
      }
    } catch (e, t) {
      _loggerService.error(e, e, t);
    }
  }

  _setupFile({required String filePath, String locale = 'en'}) async {
    try {
      final File file = File(filePath);
      final valueTemplate = {"@@locale": locale};
      await file.writeAsString(json.encode(valueTemplate));
    } catch (e) {
      rethrow;
    }
  }

  cleanApp(String appName) async {
    try {
      await appDatabase.cleanAppLanguages(appName);
      await appDatabase.cleanAppLanguages(appName);
      await appDatabase.unsetAppGenerated(appName);
      _loggerService
          .info('Cleaned [$appName] App all entries and languages are deleted');
    } catch (e) {
      _loggerService.error('Failed to Clean [$appName] App', e);
    }
  }

  resetSentenceEntries(String appName) async {
    try {
      await appDatabase.resetAppSentenceEntries(appName);
      _loggerService.info(
          'Resete All entries in [$appName] to default value (entry_generated:0) = false');
    } catch (e) {
      _loggerService.error('Failed to Clean [$appName] App', e);
    }
  }
}
