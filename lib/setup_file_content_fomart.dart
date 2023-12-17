Future<Map<String, String>> setupFileContentFomart({
  String locale = "en",
  required Map<String, String> values,
  required String appName,
}) async {
  final valueTemplate = {"@@locale": locale, ...values};

  return valueTemplate;
}
