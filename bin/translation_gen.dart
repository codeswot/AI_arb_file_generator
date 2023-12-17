import "dart:io";

import "package:translation_gen/translation_gen.dart" as translation_gen;

import "values.dart";

// use "" double quotes for values
List<String> values = [];

void main(List<String> arguments) async {
  final aiTranslatorApp = translation_gen.TranslatorApp();
  await aiTranslatorApp.start(
    sentences: privateValues, //change to the values variable above
    translateToLanguage: "french".toLowerCase(),
    appName: "mobi".toLowerCase(),
  );
  exit(0);
}
