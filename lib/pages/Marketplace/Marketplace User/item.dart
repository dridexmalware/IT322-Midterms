import 'package:flutter/material.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20User/addedtocart.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20User/checkout.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int _quantity = 0;
  int _availableQuantity = 10;
  int _rating = 0;
  String returnedData = '';

  Map<String, dynamic> orderDetails = {
    'images': [
      'https://drive.google.com/uc?export=view&id=1g7L3TM13_C05HKLNKXDbSkitobMc_-ov',
      'https://drive.google.com/uc?export=view&id=1xEDEFW_GDtPycbWw8UiUEnBfDL3q_vOH',
    ],
    'items': [
      {'name': 'Bangus', 'quantity': '1/2 kl.', 'price': '₱ 75'},
      {'name': 'Tilapia', 'quantity': '2 kls.', 'price': '₱ 360'},
    ],
    'totalPrice': '₱ 435',
    'paymentMethod': 'Cash on Delivery',
  };

  @override
  Widget build(BuildContext context) {
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
        title: const Padding(
          padding: EdgeInsets.only(),
          child: Text(
            'Bangus',
            style: TextStyle(
              color: Color.fromRGBO(25, 109, 255, 1),
              fontFamily: 'Proxima',
              fontWeight: FontWeight.w700,
              fontSize: 34,
            ),
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(top: 5, right: 15, bottom: 5),
            onPressed: () {
            },
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 20, left: 20, right: 20),
              child: Container(
                color: const Color.fromRGBO(224, 236, 248, 1),
                padding: const EdgeInsets.all(4),
                child: const Text(
                  'New',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(24, 119, 242, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: orderDetails['images'].length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            orderDetails['images'][index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                '₱ 150/kilo',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF196DFF),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: RatingStars(
                rating: _rating,
                onRatingChanged: (newRating) {
                  setState(() {
                    _rating = newRating;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Quantity:'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (_quantity >= 1) {
                            setState(() {
                              _quantity--;
                              _availableQuantity++;
                            });
                          }
                        },
                      ),
                      Text('$_quantity'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (_availableQuantity >= 1) {
                            setState(() {
                              _quantity++;
                              _availableQuantity--;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Text('Available: $_availableQuantity'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/marketplace/user/item/profile.png'),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gaga\'s Item Market',
                    ),
                    Text('Active Status'),
                    Text('Location'),
                    Text('Products: 10    Rating: 4.9'),
                  ],
                ),
                Image.asset(
                  'assets/images/marketplace/user/item/chat.png',
                  width: 73,
                  height: 73,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Guaranteed fresh and quality'),
                  SizedBox(height: 8),
                  Text('Delivery:'),
                  Text('-Delivery days: Monday to Sunday.'),
                  Text('-Available within Alubijid to Opol'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 170,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                       var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddedToCart()),
                      );
                      setState(() {
                        returnedData = result;
                      });
                    },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Color.fromRGBO(25, 109, 255, 1)),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/marketplace/user/item/cart.png',
                              width: 20, height: 20),
                          const SizedBox(width: 8),
                          const Text('Add to Cart',
                              style: TextStyle(
                                  color: Color.fromRGBO(25, 109, 255, 1))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 170,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                       var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CheckoutPage()),
                      );
                      setState(() {
                        returnedData = result;
                      });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(0),
                          ),
                        ),
                        backgroundColor: const Color.fromRGBO(25, 109, 255, 1),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
      {super.key, required this.rating, required this.onRatingChanged});

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
