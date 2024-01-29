import 'package:flutter/material.dart';
import 'package:lawod/main.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_info.dart';

class UserPassword extends StatefulWidget {
  const UserPassword({super.key});

  @override
  State<UserPassword> createState() => _UserPassword();
}

class _UserPassword extends State<UserPassword> {
  final newUserPasswordController = TextEditingController();
  final confirmUserPasswordController = TextEditingController();

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = supabase.auth.currentUser;

    if (user != null) {
      final response = await supabase
          .from('useracc')
          .select()
          .eq('email', user.email as Object)
          .single();

      // ignore: unnecessary_null_comparison
      if (response != null && response != null) {
        setState(() {
          userData = response;
        });

        // Print the user data for debugging
        // ignore: avoid_print
        print('User Data: $userData');
      }
    }
  }

  Future<void> updateUserData(String newUserPassword) async {
    final user = supabase.auth.currentUser;

    if (user != null) {
      await supabase
          .from('useracc')
          .update({'password': newUserPassword})
          .eq('email', user.email as Object)
          .single();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF4F4F4F)),
        title: const Text(
          'Password',
          style: TextStyle(
            color: Color(0xFF196DFF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Password',
                  style: TextStyle(fontSize: 20, color: Color(0xFF4F4F4F)),
                ),
                const SizedBox(height: 8),
                Text(
                  userData?['password'] ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF196DFF),
                  ),
                ),
                const SizedBox(height: 64),
                TextFormField(
                  controller: newUserPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmUserPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF196DFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      String newUserPassword = newUserPasswordController.text;
                      String confirmUserPassword = confirmUserPasswordController.text;

                      if (newUserPassword != confirmUserPassword) {
                        // Handle UserPassword mismatch error
                        return;
                      }

                      updateUserData(newUserPassword);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserInfo()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Save Changes'),
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
