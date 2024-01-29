import 'package:flutter/material.dart';

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  // Dummy data from database
  final String orderId = "LO40569863554NI";
  final String orderFrom = "Gaga's Fish Market";
  final String deliveryAddress = "Zone 3, Poblacion";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Tracking',
          style: TextStyle(color: Color(0xFF196DFF), fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Color(0xFF4F4F4F)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align to start
            children: <Widget>[
              SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/motorbike.png', // Replace with your asset image path
                  height: 200, // Adjust the size as per your requirement
                ),
              ),
              SizedBox(height: 20),
              Center( // Centered Estimated delivery time and 15 mins
                child: Column(
                  children: <Widget>[
                    Text(
                      'Estimated delivery time',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '15 mins', // This would be dynamically fetched from the database
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF0A1034)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30), // Increased space before the progress bar
              _buildProgressBar(),
              SizedBox(height: 30), // Increased space after the progress bar
              Padding( // Added padding to Tracking number
                padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
                child: Text(
                  'Tracking number',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Padding( // Added padding and adjusted colors for "GAGA" and order ID
                padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
                child: Row(
                  children: <Widget>[
                    Text(
                      'GAGA  ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      orderId,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF196DFF)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildInfoRow('You order from:', orderFrom),
              _buildInfoRow('Delivery address', deliveryAddress),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 4, 32, 4), // Added padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildProgressIndicator(isActive: true),
          Expanded(
            child: Divider(
              color: Color(0xFF196DFF),
              thickness: 2,
            ),
          ),
          _buildProgressIndicator(isActive: true),
          Expanded(
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
      backgroundColor: isActive ? Color(0xFF196DFF) : Colors.grey,
      child: isActive
          ? Icon(Icons.check, color: Colors.white)
          : Container(), // Empty container for an inactive state
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 4, 32, 4), // Added padding
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 16, color: Color(0xFF4F4F4F)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0A1034)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}