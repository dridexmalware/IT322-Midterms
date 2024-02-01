import 'package:flutter/material.dart';
import 'package:lawod/components/bottomnav.dart';
import 'package:lawod/pages/Community%20Support/community.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_info.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_account.dart';

import '../marketplace.dart';

class UserFullName extends StatefulWidget {
  const UserFullName({super.key});

  @override
  State<UserFullName> createState() => _UserFullName();
}

class _UserFullName extends State<UserFullName> {
  final newFullNameController = TextEditingController();
  final confirmFullNameController = TextEditingController();
  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Full Name',
          style: TextStyle(
            color: Color(0xFF196DFF),
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'Proxima Nova',
          ),
        ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Full Name',
                  style: TextStyle(fontSize: 20, color: Color(0xFF4F4F4F)),
                ),
                const SizedBox(height: 8),
                // Placeholder for user full name, replace as needed
                const Text(
                  'User Full Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF196DFF),
                  ),
                ),
                const SizedBox(height: 64),
                TextFormField(
                  controller: newFullNameController,
                  decoration: InputDecoration(
                    labelText: 'New Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmFullNameController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Full Name',
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
                      final newFullName = newFullNameController.text;
                      final confirmFullName = confirmFullNameController.text;

                      if (newFullName.isNotEmpty &&
                          newFullName == confirmFullName) {
                        // TODO: Implement logic for saving changes without UserProvider

                        FocusManager.instance.primaryFocus?.unfocus();
                        newFullNameController.clear();
                        confirmFullNameController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserInfo()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                                'Please enter a valid and matching Full Name.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Community()));
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MarketPlace()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserAccount()));
          }
        },
      ),
    );
  }
}
