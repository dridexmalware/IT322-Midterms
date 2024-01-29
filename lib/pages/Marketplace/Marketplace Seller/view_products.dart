import 'package:flutter/material.dart';
import 'product_details.dart';
import 'fisherfolk_page.dart';

class ViewProducts extends StatefulWidget {
  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  int _currentIndex = 0;

  void _handleNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  String dropdownValue = 'Descending Price';
  List<Map<String, String>> products = [
    {
      'productName': 'Bangus',
      'pricePerKilo': '₱ 150/kilo',
      'productImage': 'https://drive.google.com/uc?export=view&id=1g7L3TM13_C05HKLNKXDbSkitobMc_-ov',
    },
    {
      'productName': 'Tilapia',
      'pricePerKilo': '₱ 180/kilo',
      'productImage': 'https://drive.google.com/uc?export=view&id=1xEDEFW_GDtPycbWw8UiUEnBfDL3q_vOH',
    },
    {
      'productName': 'Malangasi',
      'pricePerKilo': '₱ 186/kilo',
      'productImage': 'https://drive.google.com/uc?export=view&id=1vGMoneib1Ajy3p5TBm334pFjgGgtO0uf',
    },
    {
      'productName': 'Ulang',
      'pricePerKilo': '₱ 190/kilo',
      'productImage': 'https://drive.google.com/uc?export=view&id=1rZMVViBO9S8RQ2Av3NSdd5mxACHsRIIo',
    },
    {
      'productName': 'Nokus',
      'pricePerKilo': '₱ 200/kilo',
      'productImage': 'https://drive.google.com/uc?export=view&id=1_QrZ4dlfXJW93HX6OV1Ol1wKBV0t3g8l',
    },
    {
      'productName': 'Puluan',
      'pricePerKilo': '₱ 300/kilo',
      'productImage': 'https://drive.google.com/uc?export=view&id=13eoSq63JehWqiX2LW6dkEkx_XkPi8SdU',
    },

    // Add more product data here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Products',
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Color(0xFFA7A9BE)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      style: TextStyle(color: Color(0xFFA7A9BE), fontSize: 16),
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
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8, // Adjust the aspect ratio
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProduct()),
                    );
                  },
                  child: buildProductItem(products[index]),
                );
              },
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

  Widget buildProductItem(Map<String, String> product) {
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
                  product['productName'] ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A1034),
                    fontFamily: 'Proxima Nova',
                  ),
                ),
                Text(
                  product['pricePerKilo'] ?? '',
                  style: TextStyle(
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
  final Map<String, String> productData;

  ProductDetailsPage({required this.productData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(
            color: Color(0xFF196DFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              productData['productImage'] ?? '',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productData['productName'] ?? '',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    productData['pricePerKilo'] ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF196DFF),
                    ),
                  ),
                  // Add more details here...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}