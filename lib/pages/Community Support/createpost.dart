import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
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
            const Row(
              children: [
                CircleAvatar(
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
                        'Adelfa Baclayon',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily:
                              'Proxima',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Expanded(
              child: TextField(
                maxLines: 15,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
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
              onTap: () {
              },
              child: const OptionButton(
                icon: 'assets/images/communitysupport/createpost/Photo.png',
                text: 'Photo',
              ),
            ),
            GestureDetector(
              onTap: () {
              },
              child: const OptionButton(
                icon: 'assets/images/communitysupport/createpost/Live video.png',
                text: 'Live Video',
                color: Color(0xFFFF1919),
              ),
            ),
            GestureDetector(
              onTap: () {
              },
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
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal:
                          110.0),
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
}

class OptionButton extends StatelessWidget {
  final String icon;
  final String text;
  final Color? color;

  const OptionButton({super.key, 
    required this.icon,
    required this.text,
    this.color,
  });

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
            padding: const EdgeInsets.only(
                left: 50.0),
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
                  style: const TextStyle(
                      fontFamily:
                          'Proxima'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
