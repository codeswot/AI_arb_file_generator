import 'dart:io';

import 'package:translation_gen/service/app_setup.dart';
import 'package:translation_gen/service/files_service.dart';

setupEntriesWriteToFiles({
  required List<String> keys,
  required String appName,
  required String locale,
  required Map<String, String> englishData,
  required Map<String, String> translatedData,
}) async {
  final AppSetupService appSetup = AppSetupService();
  final FilesService filesService = FilesService();
  final db = appSetup.appDatabase;

  final appFromDb = await db.getAppByName(appName).getSingleOrNull();
  final isValidEnglishFile = await filesService.validateFile(appName: appName);
  final isValidTranslatedFile =
      await filesService.validateFile(appName: appName, locale: locale);

  if (appFromDb != null && (isValidEnglishFile && isValidTranslatedFile)) {
    try {
      final englishFile = await filesService.getFile(appName: appName);
      final translatedFile =
          await filesService.getFile(appName: appName, locale: locale);

      final readEnglishFile = await englishFile.readAsString();
      final readTranslatedFile = await translatedFile.readAsString();

      late IOSink sinkEnglish;
      late IOSink sinkTranslated;
      sinkEnglish = englishFile.openWrite(mode: FileMode.append);
      sinkTranslated = translatedFile.openWrite(mode: FileMode.append);
      //
      try {
        // remove the last "}" in the file
        final modifiedJsonString = readEnglishFile.endsWith('}')
            ? '${readEnglishFile.substring(0, readEnglishFile.length - 1)} '
            : readEnglishFile;

        await englishFile.writeAsString(modifiedJsonString,
            mode: FileMode.write);

        // remove the last "}" in the file
        final modifiedJsonStringTranslated = readTranslatedFile.endsWith('}')
            ? '${readTranslatedFile.substring(0, readTranslatedFile.length - 1)} '
            : readTranslatedFile;
        await translatedFile.writeAsString(modifiedJsonStringTranslated,
            mode: FileMode.write);

        for (String key in keys) {
          // do the whole shabang
          final englishDataValue = englishData[key];
          final translatedDataValue = translatedData[key];

          // check if the key value is the last item in the list
          if (keys.last == key) {
            sinkEnglish.write(',"$key":"$englishDataValue"}');
            sinkTranslated.write(',"$key":"$translatedDataValue"}');
          } else {
            sinkEnglish.write(',"$key":"$englishDataValue"');
            sinkTranslated.write(',"$key":"$translatedDataValue"');
          }

          await sinkEnglish.flush();
          await sinkTranslated.flush();
          await Future.delayed(Duration(milliseconds: 500));
        }
      } catch (e) {
        print('Error writing to the file: $e');
      } finally {
        await sinkEnglish.close();
        await sinkTranslated.close();
      }
    } catch (e) {
      print('Error writing entries to file: $e');
    }
  }
}
