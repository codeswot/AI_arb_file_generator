import 'dart:io';

class FilesService {
  final workDir = Directory.current.path;

  String createFileIfNotExists({String appName = 'app', String locale = 'en'}) {
    // Get working directory

    final baseDirPath = '$workDir/outputs';
    final appDirPath = '$baseDirPath/$appName';

    try {
      // Create directories if they don't exist
      for (String dirPath in [baseDirPath, appDirPath]) {
        Directory dir = Directory(dirPath);
        if (!dir.existsSync()) {
          dir.createSync();
        }
      }

      File file = File('$appDirPath/app_$locale.arb');

      if (!file.existsSync()) {
        // If the file doesn't exist, create it
        file.createSync();
        print('File created at: ${file.path}');
      } else {
        print('File already exists at: ${file.path}');
      }

      return file.path;
    } catch (e) {
      print('Error occurred: $e');
      return '';
    }
  }

  Future<File> getFile({String appName = 'app', String locale = 'en'}) async {
    final baseDirPath = '$workDir/outputs';
    final appDirPath = '$baseDirPath/$appName';
    File file = File('$appDirPath/app_$locale.arb');

    final isFileExist = await file.exists();
    if (isFileExist) {
      return file;
    }
    file = File(createFileIfNotExists(appName: appName, locale: locale));
    return file;
  }

  Future<bool> validateFile(
      {String appName = 'app', String locale = 'en'}) async {
    final baseDirPath = '$workDir/outputs';
    final appDirPath = '$baseDirPath/$appName';
    File file = File('$appDirPath/app_$locale.arb');

    try {
      final isFileExist = await file.exists();
      if (isFileExist) {
        final fileContent = await file.readAsString();
        if (_isValidFileContentFormart(fileContent)) {
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  bool _isValidFileContentFormart(String content) {
    if (content.isEmpty) {
      return false;
    }
    final firstChar = content.substring(0, 1);
    final lastChar = content.substring(content.length - 1);
    final containsLocale = content.startsWith('{"@@locale":');

    if (firstChar == '{' && containsLocale && lastChar == '}') {
      return true;
    }
    return false;
  }

  bool isFileContainsEntries(String content, String locale) {
    if (content.isEmpty) {
      return false;
    }
    final firstChar = content.substring(0, 1);
    final lastChar = content.substring(content.length - 1);
    final hasAtLeasOneEntry = content.startsWith('"@@locale": "$locale","');
    if (firstChar == '{' && hasAtLeasOneEntry && lastChar == '"}') {
      return true;
    }

    return false;
  }
}
