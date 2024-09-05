import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
//http://52.172.31.221:8000/
class ApiService {
  static const String baseUrl = 'http://52.172.31.221:8000';
//'http://10.0.2.2:8001';
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

    static String getSkinColorUploadUrl() {
    return '$baseUrl/skin_color/upload/';
  }
   // URL for handling appointments
  static String getAppointmentUrl() {
    return '$baseUrl/appointments/';
  }
static String getDeleteAppointmentUrl(int appointmentId) {
    return '$baseUrl/appointments/$appointmentId';
  }

 // Method to build the URL for fetching visuals by customer attributes
  static String buildVisualsClusterUrl(String gender, String age, String incomeLevel) {
    return '$baseUrl/visuals/visuals/most_frequent_cluster?gender=$gender&age=$age&income_level=$incomeLevel';
  }

  static String getBeauticianDetailsUrl(int beauticianId) {
    return '$baseUrl/beauticians/$beauticianId';
  }

 // New: URL to fetch reviews by beautician ID
  static String getReviewsByBeauticianUrl(int beauticianId) {
    return '$baseUrl/reviews/beautician/$beauticianId';
  }

  // Utility method to get the base URL for salon services
  static String getSalonsUrl() {
    return '$baseUrl/salons/';
  }

   static String getReviewsUrl() {
    return '$baseUrl/reviews/';
  }



 // Method to post a review
  static Future<void> postReview(Map<String, dynamic> reviewData) async {
    final url = getReviewsUrl();
    final response = await postRequest(url, reviewData);

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to post review: ${response.statusCode}');
    }
  }




  // Method to get all beauticians
  static Future<List<Map<String, dynamic>>?> getAllBeauticians() async {
    final String url = '$baseUrl/beauticians/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response into a List of Maps
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((beautician) => beautician as Map<String, dynamic>).toList();
      } else {
        // Handle errors or return null
        print('Failed to load beauticians');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

    static Future<List<Map<String, dynamic>>> getNearbySalons() async {
    try {
      final position = await getCurrentLocation();
      
      // Define the search radius (in kilometers)
      const int initialRadius = 10;

      // Search within the initial radius
      List<Map<String, dynamic>> salons = await fetchSalonsWithinRadius(position.latitude, position.longitude, initialRadius);
      
      if (salons.isEmpty) {
        // If no salons found within the initial radius, search with a larger radius
        const int extendedRadius = 50; // Optional larger radius, if desired
        salons = await fetchSalonsWithinRadius(position.latitude, position.longitude, extendedRadius);
      }
      
      return salons;
    } catch (error) {
      throw Exception('Failed to load salons: $error');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchSalonsWithinRadius(double latitude, double longitude, int radius) async {
    final url = Uri.parse('${getSalonsUrl()}?lat=$latitude&lng=$longitude&radius=$radius');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> salons = jsonDecode(response.body);

      // Filter out salons that are beyond the specified radius
      return salons.where((salon) {
        double salonLat = salon['latitude'];
        double salonLng = salon['longitude'];
        double distance = Geolocator.distanceBetween(latitude, longitude, salonLat, salonLng) / 1000;
        return distance <= radius;
      }).cast<Map<String, dynamic>>().toList();
    } else {
      throw Exception('Failed to load salons: ${response.statusCode}');
    }
  }

  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

static Future<List<Map<String, String>>> fetchAllVisuals() async {
  final url = Uri.parse(getVisualsUrl());
  final response = await getRequest(url.toString());

  if (response.statusCode == 200) {
    final List<dynamic> visuals = jsonDecode(response.body);

    // Convert the dynamic list to a List<Map<String, String>>
    return visuals.map((visual) {
      return (visual as Map<String, dynamic>).map((key, value) => MapEntry(key as String, value.toString()));
    }).toList();
  } else {
    throw Exception('Failed to load all visuals');
  }
}




  // New: Method to fetch reviews by beautician ID
  static Future<List<Map<String, dynamic>>> getReviewsByBeautician(int beauticianId) async {
    final url = Uri.parse(getReviewsByBeauticianUrl(beauticianId));
    final response = await getRequest(url.toString());

    if (response.statusCode == 200) {
      final List<dynamic> reviews = jsonDecode(response.body);
      return reviews.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load reviews');
    }
  }


   static Future<Map<String, dynamic>> getBeauticianDetails(int beauticianId) async {
    final url = Uri.parse(getBeauticianDetailsUrl(beauticianId));
    final response = await getRequest(url.toString());

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load beautician details');
    }
  }

// Method to fetch visuals based on customer attributes
static Future<List<Map<String, dynamic>>> fetchVisualsByCluster(
    String gender, String age, String incomeLevel) async {
  
  final url = Uri.parse(buildVisualsClusterUrl(gender, age, incomeLevel));
  final response = await getRequest(url.toString());

  if (response.statusCode == 200) {
    final List<dynamic> visuals = jsonDecode(response.body);
    
    if (visuals.isNotEmpty) {
      // Return the entire list of visuals instead of just the first one
      return List<Map<String, dynamic>>.from(visuals);
    } else {
      throw Exception('No visuals found');
    }
  } else {
    throw Exception('Failed to load visuals');
  }
}

 
   // Method to submit an appointment
  static Future<void> postAppointment(Map<String, dynamic> appointmentData) async {
    final url = getAppointmentUrl();
    final response = await postRequest(url, appointmentData);

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to submit appointment');
    }
  }

   // New method to get appointments by customer ID
  static Future<List<Map<String, dynamic>>> getAppointmentsByCustomer(int customerId) async {
    final url = '$baseUrl/appointments/customer/$customerId';
    final response = await getRequest(url);

    if (response.statusCode == 200) {
      final List<dynamic> decodedResponse = jsonDecode(response.body);

      // Map the response to a List of Maps with the correct data structure
      return decodedResponse.map((appointment) {
        return {
          "Date": appointment['Date'],
          "Time": appointment['Time'],
          "Status": appointment['Status'],
          "Appointment_ID": appointment['Appointment_ID'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load appointments for customer ID: $customerId');
    }
  }

  
static Future<void> deleteAppointment(int appointmentId) async {
    final url = getDeleteAppointmentUrl(appointmentId);
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete appointment');
    }
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

 static Future<Map<String, dynamic>> uploadSkinColorImage(File imageFile) async {
  print('Uploading image for skin color detection: ${imageFile.path}');
  final url = Uri.parse(getSkinColorUploadUrl());
  final request = http.MultipartRequest('POST', url);

  request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);

    final String skinTone = responseData['skin_tone'];
    final List<dynamic> makeupSuggestions = responseData['makeup_suggestions'];

    // Convert List<dynamic> to List<Map<String, String>>
    final List<Map<String, String>> typedMakeupSuggestions = makeupSuggestions
        .map((item) => Map<String, String>.from(item))
        .toList();

    return {
      'skin_tone': skinTone,
      'makeup_suggestions': typedMakeupSuggestions,
    };
  } else {
    throw Exception('Failed to upload image for skin color detection');
  }
}

  



}