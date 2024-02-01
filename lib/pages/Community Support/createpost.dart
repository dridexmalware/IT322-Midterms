import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'newsfeed.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _thoughtsController = TextEditingController();

  XFile? _image;

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
        titleSpacing: 0,
        title: const Padding(
          padding: EdgeInsets.only(),
          child: Text(
            'Create Post',
            style: TextStyle(
              color: Color.fromRGBO(25, 109, 255, 1),
              fontFamily: 'Proxima',
              fontWeight: FontWeight.w700,
              fontSize: 34,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: _getUserInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error loading user data');
                } else {
                  String username = snapshot.data as String;
                  return Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/images/communitysupport/background.png'),
                        radius: 30.0,
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Proxima Nova',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: TextField(
                maxLines: 15,
                controller: _thoughtsController,
                decoration: const InputDecoration(
                  hintText: 'Additional thoughts...',
                  contentPadding: EdgeInsets.all(16.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: _pickImage,
              child: const OptionButton(
                icon: 'assets/images/communitysupport/createpost/Photo.png',
                text: 'Photo',
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle live video option
              },
              child: const OptionButton(
                icon: 'assets/images/communitysupport/createpost/Live video.png',
                text: 'Live Video',
                color: Color(0xFFFF1919),
              ),
            ),
            GestureDetector(
              onTap: _takePhoto,
              child: const OptionButton(
                icon: 'assets/images/communitysupport/createpost/Camera.png',
                text: 'Camera',
                color: Color(0xFFFFAB19),
              ),
            ),
            const SizedBox(height: 8.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _addStatusToFirestore();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 110.0),
                  backgroundColor: const Color(0xFF196DFF),
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Proxima',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getUserInfo() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(user.uid).get();

        if (userSnapshot.exists) {
          String firstName = userSnapshot['first_name'];
          String lastName = userSnapshot['last_name'];
          String username = '$firstName $lastName';
          return username;
        } else {
          print('User not found in Firestore');
          return '';
        }
      } else {
        print('User not signed in');
        return '';
      }
    } catch (e) {
      print('Error getting user info: $e');
      return '';
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> _addStatusToFirestore() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(user.uid).get();

        if (userSnapshot.exists) {
          String firstName = userSnapshot['first_name'];
          String lastName = userSnapshot['last_name'];
          String username = '$firstName $lastName';

          String documentId =
          DateTime.now().millisecondsSinceEpoch.toString();

          // Upload image to Firebase Storage
          String imagePath = ''; // Initialize with an empty string

          if (_image != null) {
            Reference storageReference = FirebaseStorage.instance
                .ref()
                .child('user_statuses')
                .child('$documentId.jpg');

            UploadTask uploadTask =
            storageReference.putFile(File(_image!.path));

            await uploadTask.whenComplete(() async {
              imagePath = await storageReference.getDownloadURL();
            });
          }

          // Add status to Firestore
          await _firestore
              .collection('users')
              .doc(user.uid)
              .collection('user_statuses')
              .doc(documentId)
              .set({
            'userId': user.uid,
            'username': username,
            'statusText': _thoughtsController.text,
            'timestamp': FieldValue.serverTimestamp(),
            'imagePath': imagePath, // Add the image path to Firestore
          });

          _thoughtsController.clear();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Status added successfully!'),
            ),
          );

          // Navigate to the NewsFeed page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NewsFeed(userId: '')),
          );
        } else {
          print('User not found in Firestore');
        }
      }
    } catch (e) {
      print('Error adding status to Firestore: $e');
    }
  }
}

class OptionButton extends StatelessWidget {
  final String icon;
  final String text;
  final Color? color;

  const OptionButton({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  height: 30,
                  width: 30,
                  color: color,
                ),
                const SizedBox(width: 16.0),
                Text(
                  text,
                  style: const TextStyle(fontFamily: 'Proxima'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
