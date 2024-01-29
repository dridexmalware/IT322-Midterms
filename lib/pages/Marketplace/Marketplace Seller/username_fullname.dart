import 'package:flutter/material.dart';
import 'package:lawod/components/userprovider.dart';
import 'package:lawod/pages/Marketplace/Marketplace Seller/user_info.dart';
import 'package:provider/provider.dart';

class UserFullName extends StatefulWidget {
  const UserFullName({super.key});

  @override
  State<UserFullName> createState() => _UserFullName();
}

class _UserFullName extends State<UserFullName> {
  final newFullNameController = TextEditingController();
  final confirmFullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF4F4F4F)),
        title: const Text(
          'Full Name',
          style:
              TextStyle(color: Color(0xFF196DFF), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Full Name',
                  style: TextStyle(fontSize: 20, color: Color(0xFF4F4F4F)),
                ),
                const SizedBox(height: 8),
                Text(
                  '${context.watch<UserProvider>().firstName} ${context.watch<UserProvider>().lastName}',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF196DFF)),
                ),
                const SizedBox(height: 64),
                TextFormField(
                  controller: newFullNameController,
                  decoration: InputDecoration(
                    labelText: 'New Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmFullNameController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF196DFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      final newFullName = newFullNameController.text;
                      final confirmFullName = confirmFullNameController.text;

                      if (newFullName.isNotEmpty &&
                          newFullName == confirmFullName) {
                        final List<String> nameParts = newFullName.split(' ');
                        final String newFirstName = nameParts.first;
                        final String newLastName =
                            nameParts.length > 1 ? nameParts.last : '';
                        context
                            .read<UserProvider>()
                            .changeFirstName(newFirstName: newFirstName);
                        context
                            .read<UserProvider>()
                            .changeLastName(newLastName: newLastName);

                        FocusManager.instance.primaryFocus?.unfocus();
                        newFullNameController.clear();
                        confirmFullNameController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserInfo()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                                'Please enter a valid and matching Full Name.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Save Changes'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
