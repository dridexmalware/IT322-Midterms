import 'package:flutter/material.dart';
import 'package:lawod/components/textfield.dart';
import 'package:lawod/models/api.dart';
import 'package:lawod/pages/homescreen_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  showStatus({required Color color, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  login(context) async {
    if (!formKey.currentState!.validate()) return;

    Map<String, dynamic> credentials = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    var response = await Api.instance.login(credentials);

    if (response.isNotEmpty) {
      var statusCode = response[1];
      if (statusCode != 200) {
        var errorMessage = response[0]['detail'];
        showStatus(color: Colors.red, text: errorMessage);
        return;
      }
    } else {
      showStatus(color: Colors.red, text: 'Unexpected response format');
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
          (route) => false,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      children: [
                        LawodTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        LawodTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 55,
                        ),
                        ElevatedButton(
                          onPressed: () => login(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF196DFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fixedSize: const Size(332, 60),
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
                        const SizedBox(height: 50),
                        Text(
                          'or sign in with',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Proxima Nova',
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Implement sign up with Google here
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fixedSize: const Size(332, 60),
                          ),
                          icon: Image.asset(
                            'assets/logos/google_logo.png',
                            height: 24,
                            width: 24,
                          ),
                          label: const Text(
                            'Sign up with Google',
                            style: TextStyle(
                              fontSize: 17,
                              height: 1.2,
                              color: Color(0xFF196DFF),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Proxima Nova',
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        GestureDetector(
                          onTap: () {
                            // Navigate to sign up page
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 17,
                                height: 1.2,
                                fontFamily: 'Proxima Nova',
                              ),
                              children: [
                                TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    color: Color(0xFF828282),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: "Sign up",
                                  style: TextStyle(
                                    color: Color(0xFF196DFF),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
