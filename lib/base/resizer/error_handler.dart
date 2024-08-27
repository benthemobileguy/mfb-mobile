import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      if (error.response != null && error.response!.data != null) {
        final data = error.response!.data;

        // Handle case where 'message' is a list of strings
        if (data['message'] is List) {
          return (data['message'] as List).join(', ');
        }

        // Handle case where 'message' is a single string
        if (data['message'] is String) {
          return data['message'];
        }

        // Additional data handling
        if (data['data']?['message'] != null) {
          return data['data']['message'];
        }
      }
    }

    // Fallback message for unexpected errors
    return "Something went wrong";
  }

  static String handleSocketException() {
    return "Poor internet connection";
  }

  static void handleAuthenticationError(
      int? statusCode, BuildContext context, Function onUnauthorized) {
    if (statusCode == 401 || statusCode == 400) {
      onUnauthorized();
    }
  }
}
