import 'package:flutter/material.dart';
import 'package:lawod/components/textfield.dart';
import 'package:lawod/models/api.dart';
import 'package:lawod/pages/login_page.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var formKey = GlobalKey<FormState>();
  final first_nameController = TextEditingController();
  final last_nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirm_passwordController = TextEditingController();

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

  register(context) async {
    if (!formKey.currentState!.validate()) return;

    Map<String, dynamic> user = {
      'first_name': first_nameController.text,
      'last_name': last_nameController.text,
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  void dispose() {
    first_nameController.dispose();
    last_nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirm_passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                constraints: const BoxConstraints(maxWidth: 600),
                // Max width for the container
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 0),
                    const Text(
                      'Create an account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        color: Color(0xFF196DFF),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Proxima Nova',
                      ),
                    ),
                    const Text(
                      'Try our digital fishing companion today!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.2,
                        color: Color(0xFF4F4F4F),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Proxima Nova',
                      ),
                    ),
                    const SizedBox(height: 40),
                    LawodTextField(
                      controller: first_nameController,
                      hintText: 'First Name',
                      obscureText: false,
                    ),
                    const SizedBox(height: 18),
                    LawodTextField(
                      controller: last_nameController,
                      hintText: 'Last Name',
                      obscureText: false,
                    ),
                    const SizedBox(height: 18),
                    LawodTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      obscureText: false,
                    ),
                    const SizedBox(height: 18),
                    LawodTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    const SizedBox(height: 18),
                    LawodTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 18),
                    LawodTextField(
                      controller: confirm_passwordController,
                      hintText: 'Confirm Password',
                      obscureText: false,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () => register(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF196DFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fixedSize: const Size(332, 60),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Proxima Nova',
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
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
                        'Already have an account?',
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

