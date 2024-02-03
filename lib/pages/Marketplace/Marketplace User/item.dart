// item.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  final String productId;

  const Item(
      {Key? key,
      required this.productId,
      required Map<String, dynamic> productData})
      : super(key: key);

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int _quantity = 0;
  int _availableQuantity = 10;
  int _rating = 0;
  String returnedData = '';

  Map<String, dynamic>? orderDetails;

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }

  void fetchProductDetails() async {
    try {
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .get();

      if (productSnapshot.exists) {
        setState(() {
          orderDetails = {
            'images': [productSnapshot['imageUrl'] ?? ''],
            'productName': productSnapshot['productName'] ?? '',
            'productPrice': productSnapshot['productPrice'] ?? '',
          };
        });
      } else {
        print('Product does not exist');
      }
    } catch (e) {
      print('Error fetching product details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          orderDetails?['productName'] ?? 'Product Name',
          style: const TextStyle(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: orderDetails?['images']?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          orderDetails?['images']?[index] ?? '',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                '₱ ${orderDetails?['productPrice'] ?? '0'}/kilo',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF196DFF),
                ),
              ),
            ),
            // ... Other widgets ...
          ],
        ),
      ),
    );
  }
}

class RatingStars extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;

  const RatingStars(
      {Key? key, required this.rating, required this.onRatingChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () {
            onRatingChanged(index + 1);
          },
          child: Icon(
            Icons.star,
            color: index < rating ? Colors.amber : Colors.grey,
          ),
        ),
      ),
    );
  }
}
