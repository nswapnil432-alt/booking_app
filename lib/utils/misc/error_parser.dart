import 'package:dio/dio.dart';

/// Utility class to parse exceptions into user-friendly error messages
class ErrorParser {
  /// Parse any exception into a user-friendly error message
  static String parse(dynamic error) {
    if (error is DioException) {
      return _parseDioException(error);
    } else if (error is String) {
      return error;
    } else {
      return 'Something went wrong. Please try again.';
    }
  }

  /// Parse DioException into user-friendly messages
  static String _parseDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet and try again.';

      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';

      case DioExceptionType.badResponse:
        return _parseHttpError(error.response?.statusCode);

      case DioExceptionType.cancel:
        return 'Request was cancelled. Please try again.';

      case DioExceptionType.badCertificate:
        return 'Security certificate error. Please contact support.';

      case DioExceptionType.unknown:
      default:
        if (error.message?.contains('SocketException') == true) {
          return 'No internet connection. Please check your network.';
        }
        return 'Unable to load data. Please try again.';
    }
  }

  /// Parse HTTP status codes into user-friendly messages
  static String _parseHttpError(int? statusCode) {
    if (statusCode == null) {
      return 'Unable to connect to server. Please try again.';
    }

    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your input.';
      case 401:
        return 'Session expired. Please login again.';
      case 403:
        return 'Access denied. You don\'t have permission to view this.';
      case 404:
        return 'Data not found. Please try again later.';
      case 408:
        return 'Request timeout. Please try again.';
      case 429:
        return 'Too many requests. Please wait a moment and try again.';
      case 500:
      case 502:
      case 503:
      case 504:
        return 'Server error. Please try again later.';
      default:
        if (statusCode >= 500) {
          return 'Server error. Please try again later.';
        } else if (statusCode >= 400) {
          return 'Unable to process request. Please try again.';
        }
        return 'Something went wrong. Please try again.';
    }
  }
}
