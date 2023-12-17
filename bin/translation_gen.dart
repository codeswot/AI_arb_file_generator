import "dart:io";

import "package:translation_gen/translation_gen.dart" as translation_gen;

// use "" double quotes for values
List<String> values = [];

void main(List<String> arguments) async {
  final aiTranslatorApp = translation_gen.TranslatorApp();
  await aiTranslatorApp.start(
    sentences: values,
    translateToLanguage: "German",
    appName: "ganD",
  );
  exit(0);
}
