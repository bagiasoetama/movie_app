import 'package:flutter/foundation.dart';

class LoggerService {
  static final List<Map<String, dynamic>> _logs = [];

  static void log({
    required String message,
    String? requestData,
    required String responseBody,
    required String statusCode,
  }) {
    if (kDebugMode) {
      _logs.add({
        'message': message,
        'requestData': requestData,
        'responseBody': responseBody,
        'statusCode': statusCode,
      });
      print('Request: $message');
      print('Request Data: $requestData');
      print('Response Body: $responseBody');
      print('Status Code: $statusCode');
    }
  }

  static List<Map<String, dynamic>> getLogs() {
    return _logs;
  }

  static void clearLogs() {
    _logs.clear();
  }
}
