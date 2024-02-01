import 'package:flutter/material.dart';
import 'package:lawod/components/button_fill.dart';
import 'package:lawod/components/textfield.dart';
import 'package:lawod/pages/Marketplace/Marketplace Seller/fisherfolk_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConsumerAccount extends StatelessWidget {
  ConsumerAccount({Key? key});

  final TextEditingController addressIdController = TextEditingController();
  final TextEditingController validIdController = TextEditingController();
  final TextEditingController IDNumberController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');
  final CollectionReference consumerCollection =
  FirebaseFirestore.instance.collection('consumers');

  Future<Map<String, dynamic>> getConsumerAccountData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await usersCollection.doc(uid).collection('accounts').doc('consumer_account').get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data() ?? {};
      } else {
        return {};
      }
    } catch (error) {
      print('Error fetching Consumer account data: $error');
      return {};
    }
  }

  Future<void> _createConsumerAccount(BuildContext context) async {
    BuildContext currentContext = context; // Initialize currentContext

    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        String uid = currentUser.uid;

        await consumerCollection.add({
          'uid': uid,
          'address': addressIdController.text,
          'validId': validIdController.text,
          'IDNumber': IDNumberController.text,
        });

        await usersCollection
            .doc(uid)
            .collection('accounts')
            .doc('consumer_account')
            .set({
          'uid': uid,
          'accountType': 'consumer', // Add this line to store the account type
          'address': addressIdController.text,
          'validId': validIdController.text,
          'IDNumber': IDNumberController.text,
        });

        ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(
          content: Text('Consumer account created successfully!'),
        ));

        // Wait for account creation to complete before navigating
        Navigator.pushReplacement(
          currentContext,
          MaterialPageRoute(
            builder: (context) => FisherfolkLanding(),
          ),
        );
      } else {
        print('User not authenticated');
      }
    } catch (error) {
      // Use the captured context for showing the snackbar
      ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(
        content: Text('Error creating Consumer account: $error'),
      ));
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
