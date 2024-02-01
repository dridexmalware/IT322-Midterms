import 'package:flutter/material.dart';
import 'package:lawod/components/button_fill.dart';
import 'package:lawod/components/textfield.dart';
import 'package:lawod/pages/Marketplace/Marketplace Seller/fisherfolk_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FisherfolkRegistration extends StatelessWidget {
  FisherfolkRegistration({super.key});

  final TextEditingController fishermanIdController = TextEditingController();
  final TextEditingController boatIdController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storeLocationController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');
  final CollectionReference fisherfolkCollection =
  FirebaseFirestore.instance.collection('fisherfolks');

  Future<void> _createFisherfolkAccount(BuildContext context) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        String uid = currentUser.uid;

        // Update the fisherfolk account data
        await usersCollection
            .doc(uid)
            .collection('accounts')
            .doc('fisherfolk_account')
            .set({
          'uid': uid,
          'accountType': 'fisherfolk', // Add this line to store the account type
          'fishermanId': fishermanIdController.text,
          'boatId': boatIdController.text,
          'storeName': storeNameController.text,
          'storeLocation': storeLocationController.text,
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FisherfolkLanding(),
          ),
        );
      } else {
        print('User not authenticated');
      }
    } catch (error) {
      print('Error creating Fisherfolk account: $error');
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
                  'Fisherfolk Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    color: Color(0xFF196DFF),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Proxima Nova',
                  ),
                ),
                const Text(
                  'Net a wider market for your catches',
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
                  controller: fishermanIdController,
                  hintText: 'Fisherman ID (Optional)',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                LawodTextField(
                  controller: boatIdController,
                  hintText: 'Boat ID (Optional)',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                LawodTextField(
                  controller: storeNameController,
                  hintText: 'Store Name',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                LawodTextField(
                  controller: storeLocationController,
                  hintText: 'Store Location',
                  obscureText: false,
                ),
                const SizedBox(height: 40),
                LawodButtonFill(
                  onPressed: () {
                    try {
                      _createFisherfolkAccount(context);
                    } catch (error) {
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
