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

   static String getVisualsUrl() {
    return '$baseUrl/visuals/';
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

  static Future<Map<String, dynamic>> getPreferences(int customerId) async {
    final url = Uri.parse('$baseUrl/preferences/$customerId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load preferences');
    }
  }

 // Method to send recommendation request and handle both List and Map response types
  static Future<List<Map<String, dynamic>>> getRecommendation(Map<String, dynamic> preferences) async {
    final formattedPreferences = {
      "styleOrientation": [preferences['Style_Orientation']],
      "speedOfService": [preferences['Speed_of_Service']],
      "beauticianInteractionStyle": [preferences['Beautician_Interaction_Style']],
      "beauticianPersonalityType": [preferences['Beautician_Personality_Type']],
      "averageTime": [preferences['Average_Time']],
    };

    final url = Uri.parse('$baseUrl/recommend/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(formattedPreferences),
    );

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      
      if (decodedResponse is List) {
        return decodedResponse.cast<Map<String, dynamic>>();
      } else if (decodedResponse is Map<String, dynamic>) {
        return [decodedResponse];  // Wrap the single object in a list
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to get recommendation');
    }
  }


    // Method to submit visual preferences including image URLs
  static Future<http.Response> submitVisualPreferences(Map<String, dynamic> preferences) async {
    final url = getVisualsUrl();
    return await postRequest(url, preferences);
  }
}