import 'package:flutter/material.dart';
import 'package:lawod/pages/login_page.dart';
import 'package:lawod/pages/signup_page.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

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
                    height: 100
                ),
                Image.asset(
                  'assets/logos/logo.png',
                  height: 143,
                  width: 149,
                ),
                const SizedBox(
                    height: 43
                ),
                const SizedBox(
                  child: Text(
                      'Navigating the\nSeas of Success',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 34,
                      height: 1.2,
                      color: Color(0xFF196DFF),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Proxima Nova',
                    ),
                  ),
                ),
                const SizedBox(
                    height: 20
                ),
                const SizedBox(
                  child: Text(
                    'Try it today and see the difference it\nmakes in your fishing experience!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.2,
                      color: Color(0xFF4F4F4F),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Proxima Nova',
                    ),
                  ),
                ),
                const SizedBox(
                    height: 100,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF196DFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: const Size(
                        313.93, 60,
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Proxima Nova',
                    ),
                  ),
                ),
                const SizedBox(
                    height: 25
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: const SizedBox(
                    child: Text(
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
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
