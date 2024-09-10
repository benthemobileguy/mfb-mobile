import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      // Log the error response for debugging purposes
      debugPrint('DioException response: ${error.response?.data}');

      // Ensure that the response and data are not null
      if (error.response != null && error.response!.data != null) {
        final data = error.response!.data;

        // Ensure the data contains the 'message' key and it's a string
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          if (data['message'] is String) {
            return data['message']; // Return the error message
          }

          // Handle case where 'message' is a list of strings
          if (data['message'] is List) {
            return (data['message'] as List).join(', ');
          }
        }

        // If no specific message is found, return the whole data as a string
        return data.toString();
      }
    }

    // Fallback message for unexpected errors or null data
    return "Something went wrong";
  }
}
