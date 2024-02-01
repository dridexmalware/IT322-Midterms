import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/fisherfolk_page.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/fisherfolk_registration.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20User/categories.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20User/consumeraccount.dart';
import '../../components/button_fill.dart';
import '../../components/button_line.dart';
import '../homescreen_page.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  late String returnedData = '';

  Future<void> _navigateToCorrectScreen(String accountType) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not logged in, so you might want to navigate to the login page.
      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      return;
    }

    final uid = user.uid;
    try {
      // Check for the consumer account
      DocumentSnapshot consumerAccountSnapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(uid)
          .collection('accounts')
          .doc('consumer')
          .get();

      // Check for the fisherfolk account
      DocumentSnapshot fisherfolkAccountSnapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(uid)
          .collection('accounts')
          .doc('fisherfolk')
          .get();

      // If accountType is 'fisherfolk' and the account exists, go to FisherfolkLanding, else go to FisherfolkRegistration
      if (accountType == 'fisherfolk') {
        if (fisherfolkAccountSnapshot.exists) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FisherfolkLanding()));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FisherfolkRegistration()));
        }
      }
      // If accountType is 'consumer' and the account exists, go to Categories, else go to ConsumerAccount for registration
      else if (accountType == 'consumer') {
        if (consumerAccountSnapshot.exists) {
          // Replace 'CategoriesPage' with the actual page you want to navigate to.
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Categories()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ConsumerAccount()));
        }
      }
    } catch (error) {
      print('Error checking user accounts: $error');
      // Handle the error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF196DFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(size: 20.0),
        leading: IconButton(
          padding: const EdgeInsets.only(top: 5, left: 15, bottom: 5),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            setState(() {
              returnedData = result;
            });
          },
          color: Colors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/marketplace/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.29,
                width: MediaQuery.of(context).size.width,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(25, 109, 255, 1),
                        ),
                        child: Image.asset(
                          'assets/images/marketplace/marketplace.png',
                          width: 50,
                          height: 50,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Marketplace',
                        style: TextStyle(
                          color: Color.fromRGBO(25, 109, 255, 1),
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w700,
                          fontSize: 34,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'From Sea to Table: Empowering Fisherfolks and Satisfying Seafood Cravings',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            height: 1.2,
                            color: Color(0xFF4F4F4F),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Proxima Nova',
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: 300,
                        height: 60,
                        child: LawodButtonLine(
                          onPressed: () async {
                            await _navigateToCorrectScreen('fisherfolk');
                          },
                          child: const Text(
                            'Sell Fish',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 300,
                        height: 60,
                        child: LawodButtonFill(
                          onPressed: () async {
                            await _navigateToCorrectScreen('consumer');
                          },
                          child: const Text(
                            'Buy Fish',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
