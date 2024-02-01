import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lawod/components/textfield.dart';
import 'package:lawod/pages/forgotpassword_page.dart';
import 'homescreen_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  'assets/logos/logo.png',
                  height: 143,
                  width: 149,
                ),
                const SizedBox(
                  height: 60,
                ),
                LawodTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                LawodTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontFamily: 'Proxima Nova',
                    ),
                  ),
                const SizedBox(
                  height: 45,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      UserCredential userCredential =
                      await _auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      // User login successful
                      print('User logged in: ${userCredential.user?.email}');

                      // Navigate to HomeScreen after successful login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } catch (e) {
                      // Handle login errors
                      print('Error logging in: $e');
                      setState(() {
                        // Set the error message to be displayed
                        errorMessage = 'Invalid email or password. Please try again.';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF196DFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: const Size(
                      332,
                      60,
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Proxima Nova',
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPassword(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.2,
                      color: Color(0xFF196DFF),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Proxima Nova',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
