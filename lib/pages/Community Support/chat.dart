import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String organizationName;

  const ChatScreen({Key? key, required this.organizationName}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _attachFile() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () async {
                  final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    _sendMessage(image.path, isImage: true);
                  }
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () async {
                  final XFile? image =
                  await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    _sendMessage(image.path, isImage: true);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendMessage(String text, {bool isImage = false}) async {
    final Timestamp timestamp = Timestamp.now();
    final String collectionPath = 'organizations/${widget.organizationName}/chats';

    await FirebaseFirestore.instance.collection(collectionPath).add({
      'senderId': 'yourSenderId', // Replace with the actual sender ID
      'message': text,
      'timestamp': timestamp,
      'isImage': isImage,
    });

    setState(() {
      _messages.add({
        'text': text,
        'sentByMe': true,
        'time': DateTime.now(),
        'isImage': isImage,
      });
    });
    _textController.clear();
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return '${time.hour}:${time.minute}';
    }
  }

  Widget _buildMessageBubble(
      bool sentByMe, String content, DateTime time, bool isImage) {
    return GestureDetector(
      onTap: () {
        if (isImage) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageViewScreen(imagePath: content)),
          );
        }
      },
      child: Row(
        mainAxisAlignment:
        sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: sentByMe
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color(0xFF196DFF),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: sentByMe
                    ? const Radius.circular(12)
                    : const Radius.circular(12),
                bottomRight: sentByMe
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
              ),
              border: Border.all(
                color: sentByMe
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : const Color(0xFF196DFF),
                width: 0.5,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isImage)
                  Image.file(
                    File(content),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  )
                else
                  Text(
                    content,
                    style: TextStyle(
                      color: sentByMe ? Colors.black : Colors.white,
                      fontFamily: 'Proxima Nova',
                      fontSize: 18,
                    ),
                    softWrap: true,
                  ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(time),
                  style: TextStyle(
                    color: sentByMe ? Colors.grey : Colors.white,
                    fontSize: 12,
                    fontFamily: 'Proxima Nova',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
          title: Text(
            widget.organizationName,
            style: const TextStyle(
              color: Color.fromRGBO(25, 109, 255, 1),
              fontFamily: 'Proxima Nova',
              fontWeight: FontWeight.w700,
              fontSize: 34,
            ),
          )),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('organizations/${widget.organizationName}/chats')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<Map<String, dynamic>> messages = snapshot.data!.docs
                    .map((DocumentSnapshot doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return {
                    'text': data['message'],
                    'sentByMe': data['senderId'] == 'yourSenderId',
                    'time': (data['timestamp'] as Timestamp).toDate(),
                    'isImage': data['isImage'],
                  };
                }).toList();

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final bool sentByMe = message['sentByMe'];
                    final String content = message['text'];
                    final DateTime time = message['time'];
                    final bool isImage = message['isImage'];

                    return _buildMessageBubble(sentByMe, content, time, isImage);
                  },
                );
              },
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _attachFile();
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7FC),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        controller: _textController,
                        style: const TextStyle(fontSize: 16.0),
                        minLines: 1,
                        maxLines: null,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          border: InputBorder.none,
                          hintText: 'Enter your message...',
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -5.0),
                  child: Transform.rotate(
                    angle: -40 * 3.14159 / 180,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFF196DFF)),
                      onPressed: () {
                        if (_textController.text.isNotEmpty) {
                          _sendMessage(_textController.text);
                        }
                      },
                    ),
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

class ImageViewScreen extends StatelessWidget {
  final String imagePath;

  const ImageViewScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
      ),
      body: Center(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
