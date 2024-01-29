import 'package:flutter/material.dart';
import 'package:lawod/components/userprovider.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_info.dart';
import 'package:provider/provider.dart';

class UserEmail extends StatefulWidget {
  const UserEmail({super.key});

  @override
  State<UserEmail> createState() => _UserEmail();
}

class _UserEmail extends State<UserEmail> {
  final newEmailController = TextEditingController();
  final confirmEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF4F4F4F)),
        title: const Text(
          'Email',
          style:
              TextStyle(color: Color(0xFF196DFF), fontWeight: FontWeight.bold),
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
                  'Email',
                  style: TextStyle(fontSize: 20, color: Color(0xFF4F4F4F)),
                ),
                const SizedBox(height: 8),
                Text(
                  context.watch<UserProvider>().email,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF196DFF)),
                ),
                const SizedBox(height: 64),
                TextFormField(
                  controller: newEmailController,
                  decoration: InputDecoration(
                    labelText: 'New Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmEmailController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Email',
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
                      context.read<UserProvider>().changeEmail(
                          newEmail: newEmailController.text);
                      FocusManager.instance.primaryFocus?.unfocus();
                      newEmailController.clear();
                      context.read<UserProvider>().changeEmail(
                          newEmail: confirmEmailController.text);
                      FocusManager.instance.primaryFocus?.unfocus();
                      confirmEmailController.clear();
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
