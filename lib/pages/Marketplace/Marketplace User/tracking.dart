import 'package:flutter/material.dart';
import 'package:lawod/components/bottomnav.dart';
import 'package:lawod/pages/Community%20Support/community.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_account.dart';
import 'package:lawod/pages/Marketplace/marketplace.dart';

class Tracking extends StatefulWidget {
  const Tracking({super.key});

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  final String orderId = "LO40569863554NI";
  final String orderFrom = "Gaga's Fish Market";
  final String deliveryAddress = "Zone 3, Poblacion";
  String? selectedIdType;
  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(top: 5, left: 15, bottom: 5),
          icon: const Icon(Icons.arrow_back_ios, size: 20.0),
          onPressed: () async {},
          color: const Color.fromRGBO(79, 79, 79, 1),
        ),
        titleSpacing: -10,
        title: const Padding(
          padding: EdgeInsets.only(),
          child: Text(
            'Tracking',
            style: TextStyle(
              color: Color.fromRGBO(25, 109, 255, 1),
              fontFamily: 'Proxima',
              fontWeight: FontWeight.w700,
              fontSize: 34,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/marketplace/user/tracking/motor.png',
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Estimated delivery time',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '15 mins',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A1034)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildProgressBar(),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.fromLTRB(32, 4, 32, 4),
                child: Text(
                  'Tracking number',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
                child: Row(
                  children: <Widget>[
                    const Text(
                      'GAGA  ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      orderId,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF196DFF)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoRow('You order from:', orderFrom),
              _buildInfoRow('Delivery address', deliveryAddress),
            ],
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

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildProgressIndicator(isActive: true),
          const Expanded(
            child: Divider(
              color: Color(0xFF196DFF),
              thickness: 2,
            ),
          ),
          _buildProgressIndicator(isActive: true),
          const Expanded(
            child: Divider(
              color: Color(0xFF196DFF),
              thickness: 2,
            ),
          ),
          _buildProgressIndicator(isActive: false),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator({required bool isActive}) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: isActive ? const Color(0xFF196DFF) : Colors.grey,
      child:
          isActive ? const Icon(Icons.check, color: Colors.white) : Container(),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, color: Color(0xFF4F4F4F)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A1034)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
