import "dart:io";

import "package:translation_gen/translation_gen.dart" as translation_gen;

import "values.dart";

// use "" double quotes for values
List<String> values = [
  "Hello",
  "World",
  "How are you?",
  "I am fine",
  "What is your name?",
  "test",
];

void main(List<String> arguments) async {
  final aiTranslatorApp = translation_gen.TranslatorGen();
  await aiTranslatorApp.start(
    sentences: privateValues, //change to the values variable above
    translateToLanguage: "Norwegian".toLowerCase(),
    appName: "carSlice".toLowerCase(),
  );
  exit(0);
}
