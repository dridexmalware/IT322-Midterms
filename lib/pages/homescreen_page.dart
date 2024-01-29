import 'package:flutter/material.dart';
import 'package:lawod/components/product.dart';
import 'package:lawod/components/weather.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:lawod/pages/Marketplace/marketplace.dart';
import 'package:lawod/pages/Community Support/community.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _SnappingListState createState() => _SnappingListState();
}

class _SnappingListState extends State<HomeScreen> {
  List<Product> productList = [
    Product('assets/images/fish_finder.png'),
    Product('assets/images/marketplace.png'),
    Product('assets/images/community_support.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                WeatherWidget(

                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 560,

                  child: ScrollSnapList(
                    itemBuilder: _buildListItem,
                    itemCount: productList.length,
                    itemSize: 380,
                    onItemFocus: (index) {},
                    dynamicItemSize: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Product product = productList[index];
    String buttonText;

    switch (index) {
      case 0:
        buttonText = 'Fish Finder';
        break;
      case 1:
        buttonText = 'Marketplace';
        break;
      case 2:
        buttonText = 'Community Support';
        break;
      default:
        buttonText = 'Explore';
    }

    return Container(
      width: 380,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30), // Adjust the radius as needed
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                product.imagePath,
                fit: BoxFit.cover,
                width: 380,
              ),
              Positioned(
                bottom: 30.0,
                left: 16.0,
                right: 16.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      buttonText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w700,
                        height: 2,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        switch (index) {
                          case 0:
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => FishFinder()),
                          // );
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MarketPlace()),
                            );
                            break;
                          case 2:
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Community()),
                            );
                            break;
                          default:
                            break;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFAB19),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                        padding: EdgeInsets.symmetric(horizontal: 115, vertical: 20),
                        // You can customize other properties such as shadow, text style, etc.
                      ),
                      child: Text(
                        'Explore',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}