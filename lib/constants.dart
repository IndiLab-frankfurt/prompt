abstract class Constants {
  static const String serverUrl = String.fromEnvironment(
    'SERVER_URL',
    defaultValue: 'https://prompt-app.eu',
  );
}
