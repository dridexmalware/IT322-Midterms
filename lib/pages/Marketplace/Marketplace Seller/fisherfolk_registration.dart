import 'package:flutter/material.dart';
import 'package:lawod/components/button_fill.dart';
import 'package:lawod/components/textfield.dart';
import 'package:lawod/pages/Marketplace/Marketplace Seller/fisherfolk_page.dart';

class FisherfolkRegistration extends StatelessWidget {
  FisherfolkRegistration({super.key});

  final TextEditingController fishermanIdController = TextEditingController();
  final TextEditingController boatIdController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storeLocationController = TextEditingController();

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
                      // Your logic to handle the button press
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FisherfolkLanding(),
                        ),
                      );
                    } catch (error) {
                      // Handle any unexpected errors
                      // ignore: avoid_print
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
