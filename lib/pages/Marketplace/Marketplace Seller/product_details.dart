import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawod/components/bottomnav.dart';
import 'package:lawod/pages/Community%20Support/community.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_account.dart';

class EditProduct extends StatefulWidget {
  final Map<String, dynamic> initialProductData;

  const EditProduct({Key? key, required this.initialProductData}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final ImagePicker _picker = ImagePicker();
  String productName = '';
  double productPrice = 0.0;
  String category = '';
  int productStock = 0;
  XFile? image;

  final int _currentIndex = 1;

  final List<String> categories = ['Fish', 'Shellfish', 'Equipment', 'Gears'];

  @override
  void initState() {
    super.initState();
    // Initialize form fields with initial product data
    productName = widget.initialProductData['productName'] ?? '';
    productPrice = widget.initialProductData['productPrice'] ?? 0.0;
    category = widget.initialProductData['category'] ?? '';
    productStock = widget.initialProductData['productStock'] ?? 0;
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? selectedImage = await _picker.pickImage(source: source);
    setState(() {
      image = selectedImage;
    });
  }

  void submitSaveDetails() async {
    // Save the details to your backend or database

    // Update the Firestore data with edited product details
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.initialProductData['productId'])
          .update({
        'productName': productName,
        'productPrice': productPrice,
        'category': category,
        'productStock': productStock,
      });

      // Show a success message or navigate to another screen
      print('Product details updated successfully!');

      // Navigate back to the ViewProducts page
      Navigator.pop(context);
    } catch (error) {
      // Handle errors, e.g., show an error message
      print('Error updating product details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Details',
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
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ... existing code ...

              ElevatedButton(
                onPressed: submitSaveDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0054E5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                ),
                child: const Text(
                  'Save Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Community()));
          } else if (index == 1) {
            // Navigate to ViewProducts page
            Navigator.pop(context);
          } else if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const UserAccount()));
          }
        },
      ),
    );
  }
}
