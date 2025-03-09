class UrlUtil {
  static const String baseUrlApi = String.fromEnvironment(
    "URL_API",
    defaultValue: 'http://localhost:5002/api',
  );
}
