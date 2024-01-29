import 'package:flutter/material.dart';
import 'newsfeed.dart';
import 'chat.dart';
import 'navbar.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsTile newsTile;

  NewsDetailPage(this.newsTile);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool isFollowed = false;

  Widget _buildActionButton(
      IconData icon, String label, Color textColor, VoidCallback onPressed) {
    return InkResponse(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            size: 24.0,
            color: textColor,
          ),
          SizedBox(width: 5.0),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Proxima',
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        titleSpacing: -15,
        title: Text(
          widget.newsTile.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF196DFF),
            fontFamily: 'Proxima',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                widget.newsTile.imagePath,
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.newsTile.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: 'Proxima',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.remove_red_eye, size: 16.0, color: Colors.black),
                    SizedBox(width: 5.0),
                    Text('100 views', style: TextStyle(color: Colors.black, fontFamily: 'Proxima')),
                    SizedBox(width: 15.0),
                    Icon(Icons.date_range, size: 16.0, color: Colors.black),
                    SizedBox(width: 5.0),
                    Text('Dec 25, 2023', style: TextStyle(color: Colors.black, fontFamily: 'Proxima')),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isFollowed = !isFollowed;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(80, 30),
                        backgroundColor: Color(0xFF196DFF),
                      ),
                      child: Text(
                        isFollowed ? 'Followed' : 'Follow',
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.newsTile.publisher}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Proxima',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.newsTile.description,
                  style: TextStyle(fontSize: 16.0, fontFamily: 'Proxima'),
                ),
              ),
              SizedBox(height: 25.0),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 0.5,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(Icons.thumb_up, 'Like', Colors.black, () {
                    }),
                    _buildActionButton(Icons.comment, 'Comment', Colors.black, () {
                    }),
                    _buildActionButton(Icons.message, 'Message', Color(0xFF196DFF), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            organizationName: widget.newsTile.publisher,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
        },
      ),
    );
  }
}
