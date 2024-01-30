import 'package:flutter/material.dart';
import 'package:lawod/components/bottomnav.dart';
import 'package:lawod/pages/Community%20Support/community.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/customer_details.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_account.dart';
import 'package:lawod/pages/Marketplace/marketplace.dart';

class OrderContent extends StatefulWidget {
  const OrderContent({super.key});

  @override
  State<OrderContent> createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  final int _currentIndex = 1;

  // Dummy data for the order details
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
        title: const Text(
          'Order Details',
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.hardEdge,
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
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const CustomerDetails()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE0ECF8),
                  foregroundColor: const Color(0xFF0A1034),
                ),
                child: const Center(
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
              margin:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF196DFF),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
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
                  const Divider(color: Colors.white),
                  ...orderDetails['items']
                      .map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text('${item['quantity']}',
                                        style: const TextStyle(
                                            color: Colors.white))),
                                Expanded(
                                    child: Text('${item['name']}',
                                        style: const TextStyle(
                                            color: Colors.white))),
                                Expanded(
                                    child: Text('${item['price']}',
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                            color: Colors.white))),
                              ],
                            ),
                          ))
                      .toList(),
                  const Divider(color: Color(0xFF196DFF)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Mode of Payment:',
                        style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0ECF8),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check,
                            color: Color(0xFF1F53E4), size: 24),
                        const SizedBox(width: 8.0),
                        Text(orderDetails['paymentMethod'],
                            style: const TextStyle(
                                color: Color(0xFF1F53E4),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Divider(color: Color(0xFF196DFF)),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text('Total: ${orderDetails['totalPrice']}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
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
