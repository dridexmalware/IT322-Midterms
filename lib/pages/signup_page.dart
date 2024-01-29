import 'package:flutter/material.dart';
import 'package:lawod/components/textfield.dart';
import 'package:lawod/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  // Controllers for text fields
  final first_nameController = TextEditingController();
  final last_nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phone_numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
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
                const SizedBox(height: 15),
                LawodTextField(
                  controller: last_nameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                LawodTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                LawodTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                LawodTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                LawodTextField(
                  controller: phone_numberController,
                  hintText: 'Phone Number',
                  obscureText: false,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    // Validation check for empty fields
                    if (first_nameController.text.isEmpty ||
                        last_nameController.text.isEmpty ||
                        usernameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        phone_numberController.text.isEmpty) {
                      return;
                    }

                    try {
                      // Get values from controllers
                      final firstName = first_nameController.text;
                      final lastName = last_nameController.text;
                      final username = usernameController.text;
                      final email = emailController.text;
                      final password = passwordController.text;
                      final phoneNumber = phone_numberController.text;

                      // Initiate the Supabase operation in the background
                      _createSupabaseAccount(
                        firstName,
                        lastName,
                        username,
                        email,
                        password,
                        phoneNumber,
                      );

                      // Immediately navigate to the login page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    } catch (error) {
                      // Handle any unexpected errors
                      print('Unexpected error: $error');
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
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
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
    );
  }
}

void _createSupabaseAccount(
  String firstName,
  String lastName,
  String username,
  String email,
  String password,
  String phoneNumber,
) async {
  try {
    // Create an account in Supabase
    final response = await Supabase.instance.client.from('useracc').upsert([
      {
        'firstname': firstName,
        'lastname': lastName,
        'username': username,
        'email': email,
        'password': password,
        'phonenumber': phoneNumber,
      }
    ]);

    // Check if the account creation was successful
    if (response != null && response.error == null) {
      print('Account created successfully');
    } else {
      // Handle error (e.g., display an error message)
      print('Error creating account: ${response?.error?.message}');
    }
  } catch (error) {
    // Handle any unexpected errors
    print('Unexpected error during account creation: $error');
  }
}
