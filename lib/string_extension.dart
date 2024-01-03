extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String toTranslateKey() {
    List<String> words = split(RegExp(r"\s+"));
    String result = "";

    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      result += i == 0 ? word.toLowerCase() : word.capitalize();
    }

    RegExp pattern = RegExp(r"[^\w\s]");

    String str = result.replaceAll(pattern, "");
    // we dont want the key to be too long, so we truncate it to 100 chars
    return str.length <= 100 ? str : str.substring(0, 100);
  }
}
