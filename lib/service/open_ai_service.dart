import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class OpenAiService {
  final String _token = String.fromEnvironment("OPENAI_TOKEN");

  Future<Map<String, dynamic>?> aiTranslator({
    required List<String> sentences,
    String translateToLanguage = 'german',
  }) async {
    final openAI = OpenAI.instance.build(
      token: _token,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true,
    );

    final request = CompleteText(
      prompt:
          'Translate these sentences "${sentences.join('", "')}" from english to $translateToLanguage response should be a json with the giving sentence as key and the translated sentence as value, note the sentences given to you are separated by " then , so do not mistake a word with a comma like this "how are you, my friend!" as separate. I only need the json response.',
      maxTokens: 200,
      model: TextDavinci3Model(),
    );

    final response = await openAI.onCompletion(request: request);
    final String rawResponseText = response?.choices[0].text ?? '';

    if (rawResponseText.isEmpty) {
      print("Translation response is empty.");
      return null;
    }
    return json.decode(rawResponseText);
  }

  Future<String> getLanguageCode(String language) async {
    try {
      final openAI = OpenAI.instance.build(
        token: _token,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
        enableLog: true,
      );

      final request = CompleteText(
        prompt:
            'return the language code for $language. Note your response should only be the correct language code, for example when given enlgish your response should be en',
        maxTokens: 200,
        model: TextDavinci3Model(),
      );

      final response = await openAI.onCompletion(request: request);
      final String? rawResponseText = response?.choices[0].text;
      if (rawResponseText == null) {
        throw Exception('Failed to find language code for $language');
      }
      return rawResponseText;
    } catch (e) {
      rethrow;
    }
  }
}
