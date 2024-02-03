import 'package:flutter/material.dart';
import 'package:lawod/components/bottomnav.dart';
import 'package:lawod/pages/Community%20Support/community.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_account.dart';
// import 'package:lawod/pages/Marketplace/Marketplace%20User/fish.dart';
import 'package:lawod/pages/Marketplace/marketplace.dart';

import '../../../components/shared_datamanager.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String? selectedIdType;

  String returnedData = '';
  final int _currentIndex = 1;

  List<Map<String, String>> products = [
    {
      'productName': 'Fish',
      'sale': '-50%',
    },
    {
      'productName': 'Shellfish',
      'sale': '-50%',
    },
    {
      'productName': 'Equipment',
      'sale': '-50%',
    },
    {
      'productName': 'Gears',
      'sale': '-50%',
    },
    {
      'productName': 'Processed',
      'sale': '-50%',
    },
    {
      'productName': 'Electronics',
      'sale': '-50%',
    },
  ];

  final List<String> productImages = [
    'assets/images/marketplace/user/categories/fish.png',
    'assets/images/marketplace/user/categories/shellfish.png',
    'assets/images/marketplace/user/categories/equipment.png',
    'assets/images/marketplace/user/categories/gears.png',
    'assets/images/marketplace/user/categories/processed.png',
    'assets/images/marketplace/user/categories/electronics.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
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
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1 / 1.2,
        ),
        itemCount: SharedDataManager.productList.length,
        itemBuilder: (context, index) {
          // Use SharedDataManager.productList[index] for each product
          return GestureDetector(
            onTap: () {
              // if (products[index]['productName'] == 'Fish') {
              //   Navigator.push(
              //     context,
              //     // MaterialPageRoute(builder: (context) => const Fish()),
              //   );
              // }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(11, 0, 0, 0),
                    spreadRadius: 0,
                    blurRadius: 40,
                    offset: Offset(8, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 10, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(224, 236, 248, 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        products[index]['sale']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(24, 119, 242, 1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 12, right: 16),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(productImages[index]),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Center(
                      child: Text(
                        products[index]['productName']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
