import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lawod/components/textfield.dart';
import 'package:lawod/pages/homescreen_page.dart';
import 'package:lawod/pages/login_page.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                  'assets/icons/sad.png',
                  height: 143,
                  width: 149,
                ),
                const SizedBox(
                  height: 60,
                ),
                LawodTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                LawodTextField(
                  controller: passwordController,
                  hintText: 'New Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                LawodTextField(
                  controller: passwordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 55,
                ),
                ElevatedButton(
                  onPressed: () {
                    final username = usernameController.text;
                    final password = passwordController.text;

                    if (username.isNotEmpty && password.isNotEmpty) {
                      // You can add your own logic here, e.g., check credentials
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } else {

                      if (kDebugMode) {
                        print('Username or password is empty');
                      }
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
                    'Save Password',
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
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Login',
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
