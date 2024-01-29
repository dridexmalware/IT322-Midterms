import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<Map<String, dynamic>> products = [
    {
      'productImage':
      'https://drive.google.com/uc?export=view&id=1g7L3TM13_C05HKLNKXDbSkitobMc_-ov',
      'productName': 'Bangus',
      'productPrice': '150.00',
    },
    {
      'productImage':
      'https://drive.google.com/uc?export=view&id=1xEDEFW_GDtPycbWw8UiUEnBfDL3q_vOH',
      'productName': 'Tilapia',
      'productPrice': '180.00',
    },
    // Add more products if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF4F4F4F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Checkout',
          style: TextStyle(color: Color(0xFF196DFF), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Color(0xFFFFAB19)),
            onPressed: () {
              // Handle cart icon press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            // Product Cards ListView.builder goes here
            Container(
              height: 325,
              padding: EdgeInsets.all(32.0),// Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: Container(
                      width: 165, // Adjust the width as needed
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.network(
                                  products[index]['productImage'],
                                  fit: BoxFit.cover,
                                  height: 160, // Adjust the height as needed
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  products[index]['productName'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  '₱${products[index]['productPrice']}/kilo',
                                  style: TextStyle(color: Color(0xFF196DFF), fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  products.removeAt(index);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Color(0xFF196DFF),
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Column(
                children: [
                  _buildInfoRow('Delivery', 'Zone 3, Poblacion Alubijid', 'via Motorcycle'),
                  Divider(color: Color(0xFF828282)),
                  _buildInfoRow('Payment', 'Cash on Delivery', null),
                  Divider(color: Color(0xFF828282)),
                  _buildInfoRow('Total', '₱330', null),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              width: double.infinity, // Ensures the button stretches to the screen width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF196DFF), // Background color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
                onPressed: () {
                  // Handle confirm order
                },
                child: Text(
                  'Confirm Order',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing at the bottom
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, String? subValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: TextStyle(color: Color(0xFF196DFF), fontWeight: FontWeight.bold)),
              if (subValue != null) Text(subValue, style: TextStyle(color: Color(0xFF196DFF))),
            ],
          )
        ],
      ),
    );
  }
}