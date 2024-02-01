import 'package:flutter/material.dart';
import 'customer_details.dart';
import 'fisherfolk_page.dart';

class OrderContent extends StatefulWidget {
  @override
  _OrderContentState createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  int _currentIndex = 0;

  void _handleNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
      // Handle navigation logic here
    });
  }

  // Dummy data for the order details
  Map<String, dynamic> orderDetails = {
    'images': [
      'https://drive.google.com/uc?export=view&id=1g7L3TM13_C05HKLNKXDbSkitobMc_-ov', // Network image URLs
      'https://drive.google.com/uc?export=view&id=1xEDEFW_GDtPycbWw8UiUEnBfDL3q_vOH', // Add more images as needed
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
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: Color(0xFF196DFF), // Blue color for the title
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip
                  .hardEdge, // Ensures the image doesn't bleed outside the border radius
              child: SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: orderDetails['images'].length,
                  itemBuilder: (context, index) {
                    return Image.network(orderDetails['images'][index],
                        fit: BoxFit.cover);
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CustomerDetails()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE0ECF8), // Button background color
                  foregroundColor: Color(0xFF0A1034), // Button text color
                ),
                child: Center(
                  child: Text(
                    'View Customer Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1034),
                      fontFamily: 'Proxima Nova',
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF196DFF),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text('Qty.',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text('Items',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text('Price',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                  Divider(color: Colors.white),
                  ...orderDetails['items']
                      .map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text('${item['quantity']}',
                                        style: TextStyle(color: Colors.white))),
                                Expanded(
                                    child: Text('${item['name']}',
                                        style: TextStyle(color: Colors.white))),
                                Expanded(
                                    child: Text('${item['price']}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Colors.white))),
                              ],
                            ),
                          ))
                      .toList(),
                  Divider(color: Color(0xFF196DFF)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Mode of Payment:',
                        style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFE0ECF8),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, color: Color(0xFF1F53E4), size: 24),
                        SizedBox(width: 8.0),
                        Text(orderDetails['paymentMethod'],
                            style: TextStyle(
                                color: Color(0xFF1F53E4),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Divider(color: Color(0xFF196DFF)),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text('Total: ${orderDetails['totalPrice']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF0A1034),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomCurvedNavigationBar(
        index: _currentIndex,
        onNavigationTap: _handleNavigationTap,
      ),
    );
  }
}
