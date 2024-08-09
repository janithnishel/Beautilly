import 'dart:convert';
import 'package:beautilly/data/onboarding_data.dart';
import 'package:beautilly/screens/customer_profile/choose_preference.dart';
import 'package:beautilly/screens/onboarding/shared_onboarding.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GlobalUser {
  static String? firstName;
  static String? profileUrl;
  static String? gender;
  static String? age;
  static String? email;
  static int? customerId; // Add Customer_ID here
}

class JoinPage extends StatelessWidget {
  JoinPage({super.key});

  // Fetch data from OnBoardingData class
  final data = OnboardingData().onBoardingListData;

  // Google Sign-In method
  Future<User?> _signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        // Store user details in global variables
        GlobalUser.firstName = user.displayName?.split(" ").first;
        GlobalUser.profileUrl = user.photoURL;
        GlobalUser.gender = "Unknown"; // Set this manually or fetch from an additional data source
        GlobalUser.age = "0";           // Set this manually or fetch from an additional data source
        GlobalUser.email = user.email;

        // Send user details to your API and handle the response
        bool isRegistered = await _sendUserDetailsToApi(
          name: GlobalUser.firstName!,
          gender: GlobalUser.gender!,
          age: GlobalUser.age!,
          email: GlobalUser.email!,
          password: "Pa\$\$w0rd", // Hardcoded password as per your requirement
        );

        if (isRegistered || GlobalUser.customerId != null) {
          // Navigate to ChoosePreference if the email is already registered or newly registered
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ChoosePreference()),
          );
        } else {
          print('Failed to retrieve Customer_ID');
        }
      }

      return user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  // Method to send user details to the API
  Future<bool> _sendUserDetailsToApi({
    required String name,
    required String gender,
    required String age,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8001/customers/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'Name': name,
        'Gender': gender,
        'Age': int.tryParse(age) ?? 0, // Convert age to integer if possible
        'Email': email,
        'Password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('User details sent successfully');
      GlobalUser.customerId = jsonDecode(response.body)['Customer_ID'];
      return false; // Not registered before, successfully saved
    } else if (response.statusCode == 400 && response.body.contains('Email is already registered')) {
      print('Email is already registered');
      GlobalUser.customerId = jsonDecode(response.body)['customer_id'];
      return true; // Email is already registered
    } else {
      print('Failed to send user details: ${response.statusCode}');
      return false; // Handle other failure cases as necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SharedScreen(
              fontsize: 20,
              bottomPadding: 265,
              title: data[3].title,
              image: data[3].imageUrl,
              description: data[3].description,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 170,
              child: GestureDetector(
                onTap: () async {
                  User? user = await _signInWithGoogle(context);
                  if (user != null) {
                    print('Google Sign-In successful: ${user.displayName}');
                  } else {
                    print('Google Sign-In failed');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(
                    isHasMultipleWidget: true,
                    title: "Join with Google",
                    color: bWhite,
                    textColor: bPrimaryColor,
                    widget: Image.asset(
                      "assets/images/googleIcon.png",
                      fit: BoxFit.cover,
                      width: 15,
                      height: 15,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 105,
              child: GestureDetector(
                onTap: () {
                  // Handle Email Sign-Up
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(
                    isHasMultipleWidget: true,
                    title: "Join with Email",
                    widget: Icon(
                      Icons.email,
                      color: bWhite,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: const Alignment(0, 0.85),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: bWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: bSecondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
