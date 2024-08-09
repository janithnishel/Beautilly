import 'package:beautilly/data/onboarding_data.dart';
import 'package:beautilly/screens/customer_profile/findservice_page.dart';
import 'package:beautilly/screens/onboarding/shared_onboarding.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GlobalUser {
  static String? firstName;
  static String? profileUrl;
  static String? gender;
  static String? age;
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
        GlobalUser.age = "Unknown";    // Set this manually or fetch from an additional data source

        // Navigate to FindService after successful sign-in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FindService()),
        );
      }

      return user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
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
