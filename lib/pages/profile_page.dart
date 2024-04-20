import 'package:flutter/material.dart';
import 'package:lawod/components/textfield.dart'; // Assuming you have TextField component
import 'package:lawod/models/api.dart'; // Assuming you have API models
import 'package:lawod/pages/login_page.dart'; // Assuming you have LoginPage
// Import other necessary dependencies if needed

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var formKey = GlobalKey<FormState>();
  final first_nameController = TextEditingController();
  final last_nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  // Remove password and confirm password controllers as they are not needed for profile page

  updateProfile(context) async {
    if (!formKey.currentState!.validate()) return;

    Map<String, dynamic> updatedUserData = {
      'first_name': first_nameController.text,
      'last_name': last_nameController.text,
      'username': usernameController.text,
      'email': emailController.text,
    };

    // Call API to update user profile using updatedUserData

    // Optionally, navigate back to a different page after profile update
    Navigator.pop(context); // Navigate back to the previous page (assuming it's the landing page)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => updateProfile(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                constraints: BoxConstraints(maxWidth: 600),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    LawodTextField(
                      controller: first_nameController,
                      hintText: 'First Name',
                      obscureText: false,
                    ),
                    SizedBox(height: 20),
                    LawodTextField(
                      controller: last_nameController,
                      hintText: 'Last Name',
                      obscureText: false,
                    ),
                    SizedBox(height: 20),
                    LawodTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      obscureText: false,
                    ),
                    SizedBox(height: 20),
                    LawodTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    SizedBox(height: 50),
                    // Add any other fields or widgets you need for the profile page
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
