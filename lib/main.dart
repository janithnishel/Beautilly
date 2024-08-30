import 'dart:convert';
import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/screens/Admin/add_preference.dart';
import 'package:beautilly/screens/Admin/saloon_visual_home.dart';
import 'package:beautilly/screens/face_pages/face_shop_details.dart';
import 'package:beautilly/screens/face_pages/face_treatment.dart';
import 'package:beautilly/screens/face_pages/face_treatment/image_uplad_page.dart';
import 'package:beautilly/screens/face_pages/face_treatment/makeup_image.dart';
import 'package:beautilly/screens/face_pages/image_uplad_page.dart';
import 'package:beautilly/screens/face_pages/makeup/makeup_image.dart';
import 'package:beautilly/screens/face_pages/makeup/makeup_selection.dart';
import 'package:beautilly/screens/join_page.dart';
import 'package:beautilly/utils/GlobalUser.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;  // Import the http package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

 await FirebaseAppCheck.instance.activate(
  androidProvider: AndroidProvider.playIntegrity,
);


  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    GlobalUser.firstName = currentUser.displayName?.split(" ").first;
    GlobalUser.profileUrl = currentUser.photoURL;
    GlobalUser.email = currentUser.email;

    await fetchCustomerDetailsAndPreferences();
  }

  runApp(const MyApp());
}

Future<void> fetchCustomerDetailsAndPreferences() async {
  int? customerId = await getCustomerIdFromApi(GlobalUser.email);
  if (customerId != null) {
    GlobalUser.customerId = customerId;
    await _checkPreferences(customerId);
   
  }
}

Future<void> _checkPreferences(int customerId) async {
  final url = ApiService.getPreferencesUrl(customerId);
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> preferences = jsonDecode(response.body);

    GlobalUser.styleOrientation = preferences['Style_Orientation'];
    GlobalUser.speedOfService = preferences['Speed_of_Service'];
    GlobalUser.beauticianInteractionStyle = preferences['Beautician_Interaction_Style'];
    GlobalUser.beauticianPersonalityType = preferences['Beautician_Personality_Type'];
    GlobalUser.averageTime = preferences['Average_Time'];

    // Additional logic based on preferences
  } else if (response.statusCode == 404) {
    print('Preferences not found for customer ID: $customerId');
  } else {
    print('Failed to check preferences: ${response.statusCode}');
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Beautilly",
      theme: ThemeData(fontFamily: "Poppins"),
      home:  MakeupImage(),
      //SaloonVisualHome
      // MakeupImage
      //MakeupSelection
    );
  }
}
//  JoinPage(),
Future<int?> getCustomerIdFromApi(String? email) async {
  if (email == null) return null;

  final url = ApiService.getCustomersUrl();
  final response = await http.get(Uri.parse('$url?email=$email'));

  if (response.statusCode == 200) {
    final List<dynamic> customers = jsonDecode(response.body);
    if (customers.isNotEmpty) {
      return customers[0]['Customer_ID'];
    } else {
      print('No customer found with the provided email');
      return null;
    }
  } else {
    print('Failed to fetch customer ID: ${response.statusCode}');
    return null;
  }
}
