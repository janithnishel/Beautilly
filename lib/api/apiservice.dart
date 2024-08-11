import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8001';

  static String getPreferencesUrl(int customerId) {
    return '$baseUrl/preferences/$customerId';
  }

  static String getCustomersUrl() {
    return '$baseUrl/customers/';
  }

  // General GET request method with error handling
  static Future<http.Response> getRequest(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      // Handle errors based on status code
      if (response.statusCode == 200 || response.statusCode == 404) {
        return response;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to make request: $e');
    }
  }

  // Example of a POST request method
  static Future<http.Response> postRequest(String url, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to make request: $e');
    }
  }

  // Example of a method to parse JSON responses
  static Map<String, dynamic> parseResponse(http.Response response) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
