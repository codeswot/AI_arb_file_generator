import "package:drift/drift.dart";
import "package:riverpod/riverpod.dart";
import "package:translation_gen/data/database.dart";
import "package:translation_gen/service/logger_service.dart";
import "package:translation_gen/service/open_ai_service.dart";
import "package:translation_gen/string_extension.dart";

class AppSetupService {
  late Database appDatabase;
  final LoggerService _loggerService = LoggerService();
  final OpenAiService _openAiService = OpenAiService();

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
    print("Setting up App...");
    final lang = language.toLowerCase();

    final app = await appDatabase.getAppByName(appName).getSingleOrNull();
    if (app != null) {
      await _setupEntries(entries, appName, lang);

      final langCode = await _setUpLanguages(appName: appName, language: lang);

      //
      final appGenerated =
          await appDatabase.getAppGenerated(appName).getSingleOrNull();
      if (appGenerated == null) {
        await appDatabase.setAppGenerated(appName);
        print("App Setup Done");
      } else {
        print("App Already Setup, aborting...");
      }
      return langCode;
    } else {
      // creates the app, recall setup();
      await _setUpApp(appName);
      return await setup(appName: appName, language: lang, entries: entries);
    }
  }

  _setUpApp(String appName) async {
    try {
      _loggerService.info("Setting up App...");
      await appDatabase.apps.insertOne(
        App(name: appName, version: 1, appGenerated: 0),
        mode: InsertMode.insertOrIgnore,
      );
    } catch (e) {
      _loggerService.info("App Exist, aborting...\nusing existing App");
    }
  }

  _setupEntries(
    List<String> entries,
    String appName,
    String languageTo, {
    String languageFrom = "english",
  }) async {
    try {
      final app = await appDatabase.getAppByName(appName).getSingleOrNull();
      if (app != null) {
        print("Setting Up all Sentence Entries...");
        await appDatabase.entries.insertAll(
          entries.map(
            (e) => SentenceEntry(
              entryId:
                  "${e.toTranslateKey()}_${appName}_${languageFrom}_$languageTo",
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
        print("App not found, creating...");
        await _setUpApp(appName);
        await _setupEntries(entries, appName, languageTo);
      }
    } catch (e, t) {
      _loggerService.error(e, e, t);
    }
  }

  Future<String> _setUpLanguages({
    required String appName,
    required String language,
  }) async {
    String languageCode = "";

    try {
      final globalLanguage = await appDatabase
          .getLanguageFromGlobalIndex(language)
          .getSingleOrNull();

      if (globalLanguage == null) {
        final languageCodeRes = await _openAiService.getLanguageCode(language);
        languageCode = languageCodeRes.split("-")[0].trim().replaceAll(" ", "");
        print("CODE $languageCode");

        await appDatabase.globalLanguages.insertOne(
          GlobalLanguage(language: language, code: languageCode),
          mode: InsertMode.insertOrIgnore,
        );
        print("Added new language [$language] to global languages");

        await appDatabase.appLanguages.insertOne(
          AppLanguage(
            appName: appName,
            language: language,
            languageCode: languageCode,
          ),
          mode: InsertMode.insertOrIgnore,
        );
        print("Added new language [$language] to App $appName");
      } else {
        await appDatabase.appLanguages.insertOne(
          AppLanguage(
            appName: appName,
            language: globalLanguage.language,
            languageCode: globalLanguage.code,
          ),
          mode: InsertMode.insertOrIgnore,
        );
        print(
            "Added new language [$language] to App $appName found from global");
      }

      return languageCode.isNotEmpty
          ? languageCode
          : globalLanguage?.code ?? languageCode;
    } catch (e) {
      print("Failed to set up languages: $e");
      rethrow;
    }
  }

  cleanApp(String appName) async {
    try {
      await appDatabase.cleanAppLanguages(appName);
      await appDatabase.cleanAppLanguages(appName);
      await appDatabase.unsetAppGenerated(appName);
      _loggerService
          .info("Cleaned [$appName] App all entries and languages are deleted");
    } catch (e) {
      _loggerService.error("Failed to Clean [$appName] App", e);
    }
  }

  resetSentenceEntries(String appName) async {
    try {
      await appDatabase.resetAppSentenceEntries(appName);
      _loggerService.info(
          "Resete All entries in [$appName] to default value (entry_generated:0) = false");
    } catch (e) {
      _loggerService.error("Failed to Clean [$appName] App", e);
    }
  }
}
