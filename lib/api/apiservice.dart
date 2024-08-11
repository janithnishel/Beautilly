import 'package:http/http.dart' as http;
class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8001';

  static String getPreferencesUrl(int customerId) {
    return '$baseUrl/preferences/$customerId';
  }

  static String getCustomersUrl() {
    return '$baseUrl/customers/';
  }

  static Future<http.Response> getRequest(String url) async {
    return await http.get(Uri.parse(url));
  }
}
