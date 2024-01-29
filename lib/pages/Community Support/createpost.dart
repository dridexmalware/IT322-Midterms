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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 20.0),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              titleSpacing: -15,
              title: Text(
                'News Feed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF196DFF),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            SizedBox(height: 16.0),
            Expanded(
              child: TextField(
                maxLines: 15,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  contentPadding: EdgeInsets.all(16.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: () {
              },
              child: OptionButton(
                icon: 'assets/images/communitysupport/createpost/Photo.png',
                text: 'Photo',
              ),
            ),
            GestureDetector(
              onTap: () {
              },
              child: OptionButton(
                icon: 'assets/images/communitysupport/createpost/Live video.png',
                text: 'Live Video',
                color: Color(0xFFFF1919),
              ),
            ),
            GestureDetector(
              onTap: () {
              },
              child: OptionButton(
                icon: 'assets/images/communitysupport/createpost/Camera.png',
                text: 'Camera',
                color: Color(0xFFFFAB19),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          110.0),
                  backgroundColor: Color(0xFF196DFF),
                ),
                child: Text(
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

  const OptionButton({
    required this.icon,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
                SizedBox(width: 16.0),
                Text(
                  text,
                  style: TextStyle(
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
