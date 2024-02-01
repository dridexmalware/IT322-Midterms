import 'package:flutter/material.dart';
import 'fisherfolk_page.dart';

class CustomerDetails extends StatefulWidget {
  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  int _currentIndex = 0;

  void _handleNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
      // Handle navigation logic here
    });
  }

  final Map<String, TextEditingController> controllers = {
    'Name': TextEditingController(text: 'Shandy Mae Pañares'),
    'Mobile Number': TextEditingController(text: '+63 912 345 6789'),
    'Landmark': TextEditingController(text: 'Near Alubijid National Comprehensive...'),
    'Address': TextEditingController(text: 'Zone 2 - Poblacion'),
    'Municipality': TextEditingController(text: 'Alubijid'),
  };

  bool isEditable = false;

  @override
  void dispose() {
    controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details', style: TextStyle(color: Color(0xFF196DFF), fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF4F4F4F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 16.0),
        children: [
          buildProductCard(),
          ...controllers.entries.map((entry) => buildEditableField(entry.key, entry.value)).toList(),
        ],
      ),
      bottomNavigationBar: CustomCurvedNavigationBar(
        index: _currentIndex,
        onNavigationTap: _handleNavigationTap,
      ),
    );
  }

  Widget buildProductCard() {
    // The product card from the previous page
    return Container(
      margin: EdgeInsets.fromLTRB(32, 16, 32, 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF196DFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://drive.google.com/uc?export=view&id=1g7L3TM13_C05HKLNKXDbSkitobMc_-ov',
              fit: BoxFit.cover,
              width: 90,
              height: 90,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order - 01',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Quantity: 3+ kilos',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            isEditable = !isEditable;
          });
        },
        child: AbsorbPointer(
          absorbing: !isEditable,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Color(0xFF4F4F4F)),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Color(0xFF0A1034)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Color(0xFF0A1034)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Color(0xFF0A1034)),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            style: TextStyle(color: Color(0xFF0A1034)),
          ),
        ),
      ),
    );
  }
}