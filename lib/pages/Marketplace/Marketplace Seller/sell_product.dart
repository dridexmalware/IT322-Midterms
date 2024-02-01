import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawod/components/bottomnav.dart';
import 'package:lawod/pages/Community%20Support/community.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/view_products.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../marketplace.dart';

class SellProduct extends StatefulWidget {
  const SellProduct({Key? key}) : super(key: key);

  @override
  State<SellProduct> createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final int _currentIndex = 1;

  String productName = '';
  int productPrice = 0;
  String category = '';
  int productStock = 0;
  XFile? image;

  final List<String> categories = ['Fish', 'Shellfish', 'Equipment', 'Gears'];

  Future<void> pickImage(ImageSource source) async {
    final XFile? selectedImage = await _picker.pickImage(source: source);
    setState(() {
      image = selectedImage;
    });
  }

  Future<void> uploadImage(String productId) async {
    try {
      if (image != null) {
        File imageFile = File(image!.path);
        String fileName = 'product_images/$productId.png';

        // Upload image to Firebase Storage
        await FirebaseStorage.instance.ref(fileName).putFile(imageFile);

        // Get download URL
        String downloadURL =
        await FirebaseStorage.instance.ref(fileName).getDownloadURL();

        // Store the download URL in Firestore
        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .update({'imageUrl': downloadURL});
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> submitSellForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> productData = {
        'productName': productName,
        'productPrice': productPrice,
        'category': category,
        'productStock': productStock,
        // Add more fields as needed
      };

      try {
        // Add product data to Firestore and get the document ID
        DocumentReference productRef = await FirebaseFirestore.instance.collection('products').add(productData);
        String productId = productRef.id;

        // Upload image to Firebase Storage and update Firestore with the image URL
        await uploadImage(productId);

        // Show a success message or navigate to another screen
        print('Product added successfully!');

        // Navigate to the View Products screen and replace the current screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ViewProducts()),
        );
      } catch (error) {
        // Handle errors, e.g., show an error message
        print('Error adding product: $error');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: const Text(
          'Start Selling',
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: const Color(0xFF828282)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: image != null
                        ? Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : const Center(
                            child: Text(
                              'Tap Button below to Upload Image',
                              style: TextStyle(color: Color(0xFF828282)),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 32,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color(0xFFE0ECF8),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                              child: Wrap(
                                children: <Widget>[
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Pick from Gallery'),
                                    onTap: () {
                                      pickImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_camera),
                                    title: const Text('Take a Photo'),
                                    onTap: () {
                                      pickImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Image.asset(
                        'assets/images/marketplaceseller/uploadPic.png',
                        width: 100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Name of the Product',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) => productName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the product';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Price (per kilo)',
                    prefixText: '₱ ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) => productPrice = int.tryParse(value) ?? 0,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price per kilo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  value: category.isEmpty ? null : category,
                  onChanged: (String? newValue) {
                    setState(() {
                      category = newValue!;
                    });
                  },
                  items:
                      categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Stock',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) => productStock = int.tryParse(value) ?? 0,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the stock information';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: submitSellForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0054E5),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  child: const Text(
                    'Sell Product',
                    style: TextStyle(
                        fontSize: 18,
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
