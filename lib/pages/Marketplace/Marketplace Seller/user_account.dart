import 'package:flutter/material.dart';
import 'package:lawod/components/userprovider.dart';
import 'package:provider/provider.dart';
import 'user_info.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  String userName =
      'Gaga’s Fish Market'; // Example username, replace with your dynamic data

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = 65.0;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(top: 5, left: 15, bottom: 5),
          icon: const Icon(Icons.arrow_back_ios, size: 20.0),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: const Color.fromRGBO(79, 79, 79, 1),
        ),
        titleSpacing: 0,
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Color.fromRGBO(25, 109, 255, 1),
            fontFamily: 'Proxima',
            fontWeight: FontWeight.w700,
            fontSize: 34,
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(top: 5, right: 15, bottom: 5),
            onPressed: () {},
            icon: Image.asset(
              'assets/images/marketplace/user/cartlogo.png',
              width: 24.0,
              height: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                SizedBox(height: avatarRadius * 2),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Column(
                      children: [
                        Text(
                          '${context.watch<UserProvider>().firstName} ${context.watch<UserProvider>().lastName}',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF196DFF)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF4F4F4F),
                            fontSize: 20,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 32),
                        GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: <Widget>[
                            _buildCard(context, 'Orders',
                                'assets/images/marketplaceseller/orders.png'),
                            _buildCard(context, 'Account Information',
                                'assets/images/marketplaceseller/accountInfo.png'),
                            _buildCard(context, 'Policy',
                                'assets/images/marketplaceseller/policy.png'),
                            _buildCard(context, 'Help',
                                'assets/images/marketplaceseller/help.png'),
                          ],
                        ),
                        const SizedBox(
                            height: 20), // Additional space at the bottom
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.12, // Adjusted for the screen size
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: avatarRadius - 5, // Small white border
                  backgroundImage: const NetworkImage(
                    'https://drive.google.com/uc?export=view&id=1Dc-e2GPOpqWgumRNt8kLVp6b_ztKI2yw',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String imagePath) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const UserInfo(),
        ));
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 80, height: 80),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}