import 'dart:convert';
import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/data/onboarding_data.dart';
import 'package:beautilly/screens/customer_profile/choose_preference.dart';
import 'package:beautilly/screens/customer_profile/findservice_page.dart';
import 'package:beautilly/screens/onboarding/shared_onboarding.dart';
import 'package:beautilly/utils/GlobalUser.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

// Admin Sign-In App Code
class AdminSignInApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminSignInScreen(),
    );
  }
}

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  void _signIn() {
    // Hardcoded credentials
    String adminUsername = 'admin';
    String adminPassword = 'password';

    if (_usernameController.text == adminUsername &&
        _passwordController.text == adminPassword) {
      setState(() {
        errorMessage = '';
      });
      // Navigate or perform successful login action
      print('Login successful');
      // Add your navigation or action here
    } else {
      setState(() {
        errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bPrimaryLightColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Admin Sign In',
                style: TextStyle(
                  color: bPrimaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  filled: true,
                  fillColor: bWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: bWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                  primary: bPrimaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: bWhite,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(
                    color: bAccentRedColor,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Main JoinPage Code
class JoinPage extends StatefulWidget {
  JoinPage({super.key});

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  bool _isLoading = false;

  final data = OnboardingData().onBoardingListData;

  Future<User?> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user != null) {
        GlobalUser.firstName = user.displayName?.split(" ").first;
        GlobalUser.profileUrl = user.photoURL;
        GlobalUser.gender = "Unknown"; // Default value
        GlobalUser.age = "00-00"; // Default value for age
        GlobalUser.email = user.email;

        bool isRegistered = await _sendUserDetailsToApi(
          name: GlobalUser.firstName!,
          gender: GlobalUser.gender!,
          age: GlobalUser.age!,
          incomeLevel: "unknown", // Include income level
          email: GlobalUser.email!,
          password: "Pa\$\$w0rd",
        );

        if (isRegistered || GlobalUser.customerId != null) {
          await _checkPreferences(context, GlobalUser.customerId!);
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

  Future<bool> _sendUserDetailsToApi({
    required String name,
    required String gender,
    required String age,
    required String incomeLevel,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(ApiService.getCustomersUrl()),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Name': name,
        'Gender': gender,
        'Age': age,
        'IncomeLevel': incomeLevel,
        'Email': email,
        'Password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      GlobalUser.customerId = jsonDecode(response.body)['Customer_ID'];
      return false;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['detail'] != null &&
          responseBody['detail']['message'] == 'Email is already registered') {
        GlobalUser.customerId = responseBody['detail']['customer_id'];
        return true;
      }
    }

    print('Failed to send user details: ${response.statusCode}');
    return false;
  }

  Future<void> _checkPreferences(BuildContext context, int customerId) async {
    final url = ApiService.getPreferencesUrl(customerId);
    final response = await ApiService.getRequest(url);

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> preferences = jsonDecode(response.body);

      GlobalUser.styleOrientation = preferences['Style_Orientation'];
      GlobalUser.speedOfService = preferences['Speed_of_Service'];
      GlobalUser.beauticianInteractionStyle =
          preferences['Beautician_Interaction_Style'];
      GlobalUser.beauticianPersonalityType =
          preferences['Beautician_Personality_Type'];
      GlobalUser.averageTime = preferences['Average_Time'];

      if (preferences.containsKey('Style_Orientation')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FindService()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChoosePreference()),
        );
      }
    } else if (response.statusCode == 404) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChoosePreference()),
      );
    } else {
      print('Failed to check preferences: ${response.statusCode}');
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
                  setState(() {
                    _isLoading = true;
                  });
                  User? user = await _signInWithGoogle(context);
                  if (user != null) {
                    print('Google Sign-In successful: ${user.displayName}');
                  } else {
                    print('Google Sign-In failed');
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(
                    isHasMultipleWidget: true,
                    title: "Join with Google",
                    color: bWhite,
                    textColor: bPrimaryColor,
                    leftSideWidget: Image.asset(
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
                    leftSideWidget: Icon(
                      Icons.email,
                      color: bWhite,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            Container(
              alignment: const Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Admin account?',
                    style: TextStyle(
                      color: bWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to AdminSignInApp
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminSignInApp(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: bSecondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
