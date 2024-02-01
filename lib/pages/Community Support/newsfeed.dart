import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'createpost.dart';
import 'newsdetails.dart';
import 'chat.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class NewsTile {
  final String title;
  final String imageUrl;
  final String publisher;
  final String description;
  final bool isFollowed;
  final DateTime timestamp;

  NewsTile({
    required this.title,
    required this.imageUrl, // Use imageUrl consistently
    required this.publisher,
    required this.description,
    this.isFollowed = false,
    required this.timestamp,
  });
}


class NewsFeed extends StatefulWidget {
  final String userId; // Pass the user ID to the NewsFeed widget

  const NewsFeed({Key? key, required this.userId}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final int _currentIndex = 0;

  // Function to upload an image to Firestore Storage
  Future<String> uploadImageToStorage(String imagePath) async {
    Reference storageReference =
    FirebaseStorage.instance.ref().child('images').child('your_image_name.jpg');
    UploadTask uploadTask = storageReference.putFile(File(imagePath));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF196DFF),
      ),
      child: Scaffold(
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
              'News Feed',
              style: TextStyle(
                color: Color.fromRGBO(25, 109, 255, 1),
                fontFamily: 'Proxima',
                fontWeight: FontWeight.w700,
                fontSize: 34,
              ),
            ),
          ),
        ),
        body: buildNewsList(),
        floatingActionButton: Container(
          width: 50.0,
          height: 50.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePost()),
              );
            },
            tooltip: 'Create Post',
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const Icon(Icons.add, size: 30, color: Colors.white),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  String _truncatePublisherName(String publisher) {
    const int maxLength = 70;

    if (publisher.length > maxLength) {
      return '${publisher.substring(0, maxLength)}...';
    }
    return publisher;
  }

  Widget buildNewsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collectionGroup('user_statuses').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final statusDocuments = snapshot.data?.docs ?? [];

        return ListView.builder(
          itemCount: statusDocuments.length,
          itemBuilder: (BuildContext context, int index) {
            final statusData = statusDocuments[index].data() as Map<String, dynamic>;

            return FutureBuilder<String>(
              future: uploadImageToStorage(statusData['imagePath'] ?? ''),
              builder: (context, imageSnapshot) {
                if (imageSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final newsTile = NewsTile(
                  title: statusData['statusText'] ?? '',
                  imageUrl: statusData['imagePath'] ?? 'https://example.com/placeholder.jpg',
                  publisher: statusData['username'] ?? '',
                  description: statusData['description'] ?? '',
                  timestamp: (statusData['timestamp'] as Timestamp).toDate(),
                );



                // Format the timestamp
                String formattedDate = DateFormat('MMMM d, y H:mm').format(newsTile.timestamp);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(newsTile),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10.0),
                        // Removed image display for simplicity
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              newsTile.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        const SizedBox(height: 5.0),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.remove_red_eye, size: 16.0),
                              const SizedBox(width: 5.0),
                              const Text('100 views'), // You can replace this with the actual view count
                              const SizedBox(width: 15.0),
                              const Icon(Icons.date_range, size: 16.0),
                              const SizedBox(width: 5.0),
                              Text(formattedDate),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Center(
                          child: Container(
                            constraints: const BoxConstraints(minWidth: 200),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  IconData(0xe958, fontFamily: 'MaterialIcons'),
                                  size: 16.0,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5.0),
                                Flexible(
                                  child: Text(
                                    _truncatePublisherName(newsTile.publisher),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Proxima',
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                organizationName: newsTile.publisher,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(80, 30),
                                          backgroundColor: const Color(0xFF196DFF),
                                        ),
                                        child: const Text(
                                          'Message',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Proxima',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
