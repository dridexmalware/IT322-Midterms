import 'package:flutter/material.dart';
import 'package:lawod/components/bottomnav.dart';
import 'package:lawod/pages/Community%20Support/community.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_account.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_info.dart';
import 'package:lawod/pages/Marketplace/marketplace.dart';

class UserPhoneNumber extends StatefulWidget {
  const UserPhoneNumber({super.key});

  @override
  State<UserPhoneNumber> createState() => _UserPhoneNumber();
}

class _UserPhoneNumber extends State<UserPhoneNumber> {
  final newUserPhoneNumberController = TextEditingController();
  final confirmUserPhoneNumberController = TextEditingController();
  final int _currentIndex = 1;

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    // Commenting out the Supabase-related function call
    // fetchUserData();
  }

  // Commenting out the Supabase-related function
  // Future<void> fetchUserData() async {
  //   // ...
  // }

  // Commenting out the Supabase-related function
  // Future<void> updateUserData(String newUserPhoneNumber) async {
  //   // ...
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phone Number',
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
                  'Phone Number',
                  style: TextStyle(fontSize: 20, color: Color(0xFF4F4F4F)),
                ),
                const SizedBox(height: 8),
                // Placeholder for user phone number, replace as needed
                const Text(
                  'User Phone Number',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF196DFF),
                  ),
                ),
                const SizedBox(height: 64),
                TextFormField(
                  controller: newUserPhoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'New Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmUserPhoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Phone Number',
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
                      String newUserPhoneNumber = newUserPhoneNumberController.text;
                      String confirmUserPhoneNumber = confirmUserPhoneNumberController.text;

                      if (newUserPhoneNumber != confirmUserPhoneNumber) {
                        // Handle UserPhoneNumber mismatch error
                        return;
                      }

                      // TODO: Implement logic for saving changes without Supabase

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
