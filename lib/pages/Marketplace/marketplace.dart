import 'package:flutter/material.dart';
import 'package:lawod/pages/Marketplace/Marketplace Seller/fisherfolk_registration.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20User/consumeraccount.dart';
import '../homescreen_page.dart';
import 'package:lawod/components/button_fill.dart';
import 'package:lawod/components/button_line.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  late String returnedData = '';

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
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FisherfolkRegistration(),
                              ),
                            );
                            setState(() {
                              returnedData = result;
                            });
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
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConsumerAccount(),
                              ),
                            );
                            setState(() {
                              returnedData = result;
                            });
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
