import "package:translation_gen/service/app_setup.dart";
import "package:translation_gen/service/files_service.dart";
import "package:translation_gen/service/generate_service.dart";
import "package:translation_gen/service/logger_service.dart";

class TranslatorGen {
  final LoggerService _loggerService = LoggerService();
  final AppSetupService _appSetupService = AppSetupService();
  final FilesService _filesService = FilesService();
  final GenerateService _generateService = GenerateService();

  int _retryCount = 0;
  final _maxRetries = 5;

  Future<void> start({
    required List<String> sentences,
    String translateToLanguage = "german",
    String appName = "app",
  }) async {
    if (sentences.isEmpty) {
      print("No sentences/words found to process");
      return;
    }
    final language = translateToLanguage.toLowerCase();

    if (language == "english") {
      _loggerService.info(
          "You cannot translate from English to $language; select another language");
      return;
    }

    /// sort sentence with shortest first
    sentences.sort((a, b) => a.length.compareTo(b.length));

    /// setup the current app and return the language code
    final languageCode = await _appSetupService.setup(
      appName: appName,
      language: language,
      entries: sentences,
    );

    /// if language code is null, it means the setup failed, retry `setup`
    if (languageCode == null) {
      if (_retryCount >= _maxRetries) {
        print("Max retries reached, exiting");
        return;
      }
      print(
          "Setup failed, will retry in 10 seconds, retry count: $_retryCount of $_maxRetries");

      await Future.delayed(Duration(seconds: 10), () async {
        await start(
          sentences: sentences,
          translateToLanguage: translateToLanguage,
          appName: appName,
        );
        _retryCount += 1;
        print("Retrying...");
      });

      return;
    }

    _retryCount = 0;

    /// setup done, begin translation
    print("Initializing translations for $language:$languageCode...");
    await _generateService.batchTranslationGenerate(
      appName: appName,
      language: language,
    );
    await _generateService.writeGeneratedEntriesToFile(
      appName,
      language,
    );

    print(
        "All Done! Check ${_filesService.workDir}/output/$appName folder for the generated files");
  }
}
