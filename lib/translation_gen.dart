import 'dart:convert';
import 'package:translation_gen/data/database.dart';
import 'package:translation_gen/service/app_setup.dart';
import 'package:translation_gen/service/files_service.dart';
import 'package:translation_gen/service/logger_service.dart';
import 'package:translation_gen/service/open_ai_service.dart';

class TranslatorApp {
  final LoggerService _loggerService = LoggerService();
  final AppSetupService _appSetupService = AppSetupService();
  final OpenAiService _openAiService = OpenAiService();
  final FilesService _filesService = FilesService();

  final Map<String, String> _translationData = {};
  final Map<String, String> _inputData = {};
  int _retryCount = 0;
  final _maxRetries = 5;

  Future<void> start({
    required List<String> sentences,
    String translateToLanguage = 'german',
    String appName = 'app',
  }) async {
    if (sentences.isEmpty) {
      print('No sentences found to process');
      return;
    }
    final language = translateToLanguage.toLowerCase();
    if (language == 'english') {
      _loggerService.info(
          "You cannot translate from English to $language; select another language");
      return;
    }
    sentences.sort((a, b) => a.length.compareTo(b.length));
    final languageCode = await _appSetupService.setup(
      appName: appName,
      language: language,
      entries: sentences,
    );

    if (languageCode == null) {
      if (_retryCount >= _maxRetries) {
        print('Max retries reached, exiting');
        return;
      }
      print(
          'Setup failed, will retry in 10 seconds, retry count: $_retryCount of $_maxRetries');

      await Future.delayed(Duration(seconds: 10), () async {
        await start(
          sentences: sentences,
          translateToLanguage: translateToLanguage,
          appName: appName,
        );
        _retryCount += 1;
        print('Retrying...');
      });

      return;
    }

    _retryCount = 0;

    print('Initializing translations for $language:$languageCode...');
    await _batchTranslationGenerate(appName: appName, language: language);
    await _writeGeneratedEntriesToFile(appName, language);

    print(
        'All Done! Check ${_filesService.workDir}/output/$appName folder for the generated files');
  }

  Future<void> _batchTranslationGenerate({
    required String appName,
    required String language,
    int batchSize = 3,
    int delayInSeconds = 20,
  }) async {
    try {
      final entries = await _appSetupService.appDatabase
          .getAllSentenceEntryWhereNotGeneratedForLang(
            appName,
            'english', //for now only english
            language,
          )
          .get();
      if (entries.isEmpty) {
        print('No entries found');
        return;
      }
      print('Found ${entries.length} entries:$entries');
      for (int i = 0; i < entries.length; i += batchSize) {
        int endIndex =
            (i + batchSize < entries.length) ? i + batchSize : entries.length;
        List<SentenceEntry> batch = entries.sublist(i, endIndex);
        final batchTranslateFromValues =
            batch.map((e) => e.entryTranslationFrom).toList();
        final batchIds = batch.map((e) => e.entryId).toList();
        // final batchKeys = batch.map((e) => e.entryKey).toList();
        print("Batch $i-${endIndex - 1}: currently running");

        try {
          final translationData = await _openAiService.aiTranslator(
            sentences: batchTranslateFromValues,
            translateToLanguage: language.toLowerCase(),
          );

          if (translationData != null) {
            for (int j = 0; j < batchTranslateFromValues.length; j++) {
              final translatedValue =
                  translationData[batchTranslateFromValues[j]] as String? ??
                      'Translation not available';
              // print(
              //     'Translated ${batchTranslateFromValues[j]} to $translatedValue');
              if (translatedValue != 'Translation not available') {
                await _appSetupService.appDatabase
                    .setEntryTranslation(translatedValue, appName, batchIds[j]);
              } else {
                print(
                    'failed [${batchTranslateFromValues[j]}] an error occurred: failed to translate to $language');
              }
            }
          }
        } catch (e) {
          print('failed [${batchTranslateFromValues}] an error occurred: $e');
        }

        if (endIndex < entries.length) {
          print(
              'BATCH INFO START ---------------------------------------------------------- BATCH INFO START');
          print(
              'Number of items processed: ${i + batchTranslateFromValues.length}/${entries.length}');
          print(
              'Number of items left: ${entries.length - (i + batchTranslateFromValues.length)}');
          print(
              'Progress: ${((i + batchTranslateFromValues.length) / entries.length * 100).toStringAsFixed(2)}%');
          print(
              'BATCH INFO END ---------------------------------------------------------- BATCH INFO END');
          print('Next batch after $delayInSeconds seconds');
          await Future.delayed(Duration(seconds: delayInSeconds));
        }
      }
    } catch (e) {
      print('An error occurred: $e');
      // Handle the error or rethrow if needed.
    }
  }

//
  Future<void> _writeGeneratedEntriesToFile(
      String appName, String language) async {
    final entries = await _appSetupService.appDatabase
        .getAllSentenceEntryWhereGeneratedForLang(
          appName,
          'english', //for now only english
          language,
        )
        .get();
    for (var entry in entries) {
      if (entry.entryTranslationTo != null) {
        await _populateLanguageMaps(
          key: entry.entryKey,
          translateToValue: entry.entryTranslationTo!,
          translatedFromValue: entry.entryTranslationFrom,
        );
      }
    }
    final currentLanguage = await _appSetupService.appDatabase
        .getAppLanguage(appName, language)
        .getSingleOrNull();
    if (currentLanguage != null) {
      //
      final englishContentTemplate = {"@@locale": "en", ..._inputData};
      final translatedContentTemplate = {
        "@@locale": currentLanguage.languageCode,
        ..._translationData
      };
      //
      final englishFile = await _filesService.getFile(appName: appName);
      final translatedFile = await _filesService.getFile(
          appName: appName, locale: currentLanguage.languageCode);
      //
      await englishFile.writeAsString(json.encode(englishContentTemplate));
      await translatedFile
          .writeAsString(json.encode(translatedContentTemplate));
      //
    }
  }

  Future<void> _populateLanguageMaps({
    required String key,
    required String translateToValue,
    required String translatedFromValue,
  }) async {
    _translationData[key] = translateToValue;
    _inputData[key] = translatedFromValue;
  }
}
