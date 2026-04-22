import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get baseUrl => dotenv.env['BASE_URL']?.trim() ?? '';

  static String get apiColombiaBaseUrl {
    final raw = dotenv.env['API_COLOMBIA_BASE_URL']?.trim();
    return (raw == null || raw.isEmpty)
        ? 'https://api-colombia.com/api/v1'
        : raw;
  }

  static String get datasetId => dotenv.env['DATASET_ID']?.trim() ?? '';

  static String get appToken => dotenv.env['APP_TOKEN']?.trim() ?? '';

  static String get fullUrl {
    final normalizedBaseUrl = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    return '$normalizedBaseUrl$datasetId';
  }

  static String get apiColombiaDepartmentUrl {
    final normalizedBase = apiColombiaBaseUrl.endsWith('/')
        ? apiColombiaBaseUrl
        : '$apiColombiaBaseUrl/';
    return '${normalizedBase}Department';
  }

  static Map<String, String> get defaultHeaders => {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    if (appToken.isNotEmpty) 'X-App-Token': appToken,
  };
}
