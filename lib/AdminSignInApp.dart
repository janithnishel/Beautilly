import 'package:flutter/material.dart';

const bPrimaryColor = Color(0xff156778);
const bPrimaryLightColor = Color(0xffE1F5FA);
const bSecondaryColor = Color(0xffF98600);
const bSecondaryLightColor = Color(0xffFFF9E5);
const bAccentRedColor = Color(0xffED4C5C);
const bAccentLightColor = Color(0xffFEF1F2);
const bWhite = Color(0xffffffff);
const bBlackColor = Color(0xff000000);
const bDarkGrey = Color(0xff303030);
final bhightLightGrey = const Color(0xff000000).withOpacity(0.1);
final bLowLightGrey = const Color(0xff000000).withOpacity(0.05);
final bGrey = const Color(0xff000000).withOpacity(0.5);


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
