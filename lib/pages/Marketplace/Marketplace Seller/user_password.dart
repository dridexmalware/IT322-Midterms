import 'package:flutter/material.dart';
import 'package:lawod/components/userprovider.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_info.dart';
import 'package:provider/provider.dart';

class UserPassword extends StatefulWidget {
  const UserPassword({super.key});

  @override
  State<UserPassword> createState() => _UserPassword();
}

class _UserPassword extends State<UserPassword> {
  final newUserPasswordController = TextEditingController();
  final confirmUserPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme:
            const IconThemeData(color: Color(0xFF4F4F4F)),
        title: const Text(
          'UserPassword',
          style: TextStyle(
              color: Color(0xFF196DFF),
              fontWeight: FontWeight.bold),
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
                  context.watch<UserProvider>().password,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF196DFF)),
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
                      backgroundColor:
                          const Color(0xFF196DFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      context.read<UserProvider>().changePassword(
                          newPassword: newUserPasswordController.text);
                      FocusManager.instance.primaryFocus?.unfocus();
                      newUserPasswordController.clear();
                      context.read<UserProvider>().changePassword(
                          newPassword: confirmUserPasswordController.text);
                      FocusManager.instance.primaryFocus?.unfocus();
                      confirmUserPasswordController.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UserInfo()),
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
