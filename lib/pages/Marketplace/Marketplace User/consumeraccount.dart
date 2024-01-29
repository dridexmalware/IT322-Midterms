import 'package:flutter/material.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20User/categories.dart';

class ConsumerAccount extends StatefulWidget {
  const ConsumerAccount({super.key});

  @override
  State<ConsumerAccount> createState() => _ConsumerAccountState();
}

class _ConsumerAccountState extends State<ConsumerAccount> {
  String? selectedIdType;

  String returnedData = '';

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
      ),
      extendBodyBehindAppBar: true,
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Consumer Account',
                style: TextStyle(
                  color: Color.fromRGBO(25, 109, 255, 1),
                  fontFamily: 'Proxima',
                  fontWeight: FontWeight.w700,
                  fontSize: 34,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Reel in the best deals from local fishers!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Proxima',
                  color: Color.fromRGBO(79, 79, 79, 1),
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: 300,
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Address',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                height: 60,
                child: DropdownButtonFormField<String>(
                  value: selectedIdType,
                  decoration: InputDecoration(
                    hintText: 'Valid Identification Card',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  items: <String>[
                    'Driver\'s License',
                    'Passport',
                    'ID Card',
                    'Others'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedIdType = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'ID Number',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Categories()),
                    );
                    setState(() {
                      returnedData = result;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(25, 109, 255, 1)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Proxima',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
