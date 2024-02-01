import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lawod/components/bottomnav.dart';
import 'package:lawod/pages/Community%20Support/community.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/product_details.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_account.dart';
import 'package:lawod/pages/Marketplace/marketplace.dart';

class ViewProducts extends StatefulWidget {
  final int _currentIndex = 1;

  const ViewProducts({super.key});

  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  String dropdownValue = 'Descending Price'; // Declare dropdownValue here
  List<Map<String, dynamic>> products = []; // Declare products here

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    // Fetch products from Firestore (replace 'products' with your actual collection name)
    QuerySnapshot productSnapshot =
    await FirebaseFirestore.instance.collection('products').get();

    // Convert Firestore data to a list of Map<String, dynamic>
    List<Map<String, dynamic>> updatedProducts =
    productSnapshot.docs.map((DocumentSnapshot document) {
      return {
        'productName': document['productName'],
        'pricePerKilo': '₱ ${document['productPrice']}/kilo',
        'productImage': document['imageUrl'],
        // Add more fields as needed
      };
    }).toList();

    // Update the state to trigger a rebuild with the new product data
    setState(() {
      products = updatedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Product',
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xFFA7A9BE)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      style:
                      const TextStyle(color: Color(0xFFA7A9BE), fontSize: 16),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Ascending Price', 'Descending Price']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Pass the product data to the ProductDetailsPage screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsPage(productData: products[index]),
                      ),
                    );
                  },
                  child: buildProductItem(products[index]),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: widget._currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Community()));
          } else if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const MarketPlace()));
          } else if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const UserAccount()));
          }
        },
      ),
    );
  }

  Widget buildProductItem(Map<String, dynamic> product) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product['productImage'] ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['productName'] ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A1034),
                    fontFamily: 'Proxima Nova',
                  ),
                ),
                Text(
                  product['pricePerKilo'] ?? 'No Price',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF196DFF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductDetailsPage({Key? key, required this.productData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProduct(initialProductData: productData),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}