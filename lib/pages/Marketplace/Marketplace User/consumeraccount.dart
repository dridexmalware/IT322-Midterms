import 'package:flutter/material.dart';
import 'package:lawod/components/button_fill.dart';
import 'package:lawod/components/textfield.dart';
import 'package:lawod/pages/Marketplace/Marketplace Seller/fisherfolk_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20User/categories.dart';

class ConsumerAccount extends StatelessWidget {
  ConsumerAccount({Key? key});

  final TextEditingController addressIdController = TextEditingController();
  final TextEditingController validIdController = TextEditingController();
  final TextEditingController IDNumberController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> _userHasCompletedConsumerRegistration(String uid) async {
    final consumerAccountDoc = await _firestore
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc('consumer_account')
        .get();

    if (consumerAccountDoc.exists && consumerAccountDoc.data() != null) {
      final data = consumerAccountDoc.data()!;
      return data['registrationComplete'] ==
          true; // Check if registration is complete
    }
    return false; // No consumer account document found, or registration not complete
  }

  Future<void> _createConsumerAccount(BuildContext context) async {
    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      print('User not authenticated.');
      // TODO: Navigate to login page or show an error message
      return;
    }

    final uid = currentUser.uid;
    final hasCompletedRegistration =
        await _userHasCompletedConsumerRegistration(uid);

    if (hasCompletedRegistration) {
      // If registration is complete, navigate to the categories page or consumer landing page
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Categories()));
      return;
    }

    // If the registration is not complete, create the consumer account
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('accounts')
          .doc('consumer') // Changed from 'consumer_account' to 'consumer'
          .set({
        'address': addressIdController.text,
        'validId': validIdController.text,
        'IDNumber': IDNumberController.text,
        'registrationComplete': true, // Set the registration as complete.
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Consumer account created successfully!')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Categories()));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating Consumer account: $error')),
      );
      print('Error creating Consumer account: $error');
    }
  }

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
                  'Consumer Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    color: Color(0xFF196DFF),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Proxima Nova',
                  ),
                ),
                const Text(
                  'Reel in the best deals from local fishers',
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
                  controller: addressIdController,
                  hintText: 'Address',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                LawodTextField(
                  controller: validIdController,
                  hintText: 'Valid Identification Card',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                LawodTextField(
                  controller: IDNumberController,
                  hintText: 'ID Number',
                  obscureText: false,
                ),
                const SizedBox(height: 40),
                LawodButtonFill(
                  onPressed: () {
                    try {
                      // Wait for account creation to complete before navigating
                      _createConsumerAccount(context);
                    } catch (error) {
                      // Handle any unexpected errors
                      print('Unexpected error: $error');
                    }
                  },
                  child: const Text(
                    'Create Account',
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
