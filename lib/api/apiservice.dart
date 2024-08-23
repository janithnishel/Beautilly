import 'dart:convert';
import 'dart:io';
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

   static String getCustomerUrl(int customerId) {
    return '$baseUrl/customers/$customerId';
  }

    static String getUpdateCustomerUrl() {
    return '$baseUrl/customers/update_customer';
  }


 static String getClusterPredictUrl() {
    return '$baseUrl/cluster/predict/';
  }

   // URL for the acne detection API
  static String getDetectAcneUrl() {
    return '$baseUrl/skin_deseases/detect_acne';
  }

    static String getVisualsByCustomerAttributesUrl(String gender, String age, String incomeLevel) {
    return '$baseUrl/visuals/visuals_by_customer_attributes?gender=$gender&age=$age&income_level=$incomeLevel';
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


  static Future<http.Response> putRequest(Uri url, Map<String, dynamic> body) async {
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to make request: $e');
    }
  }

  // Method to fetch customer details
  static Future<Map<String, dynamic>> getCustomer(int customerId) async {
    final url = getCustomerUrl(customerId);
    final response = await getRequest(url);
    return parseResponse(response);
  }

static Future<http.Response> updateCustomer(Map<String, dynamic> customerDetails) async {
  final url = Uri.parse(getUpdateCustomerUrl());  // Convert the String URL to a Uri
  return await putRequest(url, customerDetails);  // Use PUT instead of POST
}

// Method to submit data for cluster prediction
  static Future<http.Response> submitClusterPrediction(Map<String, dynamic> predictionData) async {
    final url = getClusterPredictUrl();
    return await postRequest(url, predictionData);
  }

static Future<Map<String, dynamic>> uploadImageForAcneDetection(File imageFile) async {
    print('Uploading image: ${imageFile.path}'); // Add this line
    final url = Uri.parse(getDetectAcneUrl());
    final request = http.MultipartRequest('POST', url);

    // Add the file to the request
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}'); // Add this line
    print('Response body: ${response.body}'); // Add this line

    if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
        throw Exception('Failed to detect acne');
    }
}

// static Future<List<Map<String, dynamic>>> getVisualsByCustomerAttributes(String gender, String age, String incomeLevel) async {
//     final url = Uri.parse(getVisualsByCustomerAttributesUrl(gender, age, incomeLevel));
//     final response = await getRequest(url.toString());

//     if (response.statusCode == 200) {
//       final List<dynamic> visuals = jsonDecode(response.body);
//       return visuals.cast<Map<String, dynamic>>();
//     } else {
//       throw Exception('Failed to load visuals');
//     }
//   }
static Future<Map<String, dynamic>> getVisualsByCustomerAttributes(
    String gender, String age, String incomeLevel) async {
  final url = Uri.parse(getVisualsByCustomerAttributesUrl(gender, age, incomeLevel));
  final response = await getRequest(url.toString());

  if (response.statusCode == 200) {
    final List<dynamic> visuals = jsonDecode(response.body);
    if (visuals.isNotEmpty) {
      return visuals[0]; // Return the first visual if the list is not empty
    } else {
      throw Exception('No visuals found');
    }
  } else {
    throw Exception('Failed to load visuals');
  }
}



}