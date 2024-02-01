import 'package:flutter/material.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_info.dart';

class UserName extends StatefulWidget {
  const UserName({super.key});

  @override
  State<UserName> createState() => _UserName();
}

class _UserName extends State<UserName> {
  final newUsernameController = TextEditingController();
  final confirmUsernameController = TextEditingController();

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF4F4F4F)),
        title: const Text(
          'Username',
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
                  'Username',
                  style: TextStyle(fontSize: 20, color: Color(0xFF4F4F4F)),
                ),
                const SizedBox(height: 8),
                Text(
                  userData?['username'] ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF196DFF),
                  ),
                ),
                const SizedBox(height: 64),
                TextFormField(
                  controller: newUsernameController,
                  decoration: InputDecoration(
                    labelText: 'New Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmUsernameController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Username',
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
                      String newUsername = newUsernameController.text;
                      String confirmUsername = confirmUsernameController.text;

                      if (newUsername != confirmUsername) {
                        // Handle username mismatch error
                        return;
                      }


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
