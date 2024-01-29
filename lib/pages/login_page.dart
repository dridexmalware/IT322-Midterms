  import 'package:flutter/foundation.dart';
  import 'package:flutter/material.dart';
  import 'package:lawod/components/textfield.dart';
  import 'package:lawod/pages/homescreen_page.dart';
  import 'package:supabase_flutter/supabase_flutter.dart';
  import 'package:lawod/pages/forgotpassword_page.dart';

  class LoginPage extends StatelessWidget {
    LoginPage({super.key});

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
                    'assets/logos/logo.png',
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
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final username = usernameController.text;
                      final password = passwordController.text;

                      if (username.isEmpty || password.isEmpty) {
                        return;
                      }

                      final supabase = SupabaseClient(
                        "https://jygarouldipjiciutnlg.supabase.co",
                        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp5Z2Fyb3VsZGlwamljaXV0bmxnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDYyMDA4NzcsImV4cCI6MjAyMTc3Njg3N30.-bxjnhydAnslNGGAtkZ3DLXUyDXiIVISeWCE13MaGBA",
                      );

                      final response = await supabase
                          .from('useracc')
                          .select()
                          .eq('username', username)
                          .eq('password', password);

                      // ignore: unnecessary_null_comparison
                      if (response != null && response .isNotEmpty) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      } else {
                        // Show an error message or take any other appropriate action
                        // For now, you can print a message to the console
                        if (kDebugMode) {
                          print('Invalid username or password');
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