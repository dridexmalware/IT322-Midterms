import 'package:flutter/material.dart';
import 'package:lawod/components/bottomnav.dart';
import 'package:lawod/pages/Community%20Support/community.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_account.dart';
import 'package:lawod/pages/Marketplace/marketplace.dart';
import 'newsfeed.dart';
import 'chat.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsTile newsTile;

  const NewsDetailPage(this.newsTile, {super.key});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool isFollowed = false;
  final int _currentIndex = 0;

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
          const SizedBox(width: 5.0),
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
        title: 
        Text(
            widget.newsTile.title,
            style: const TextStyle(
              color: Color.fromRGBO(25, 109, 255, 1),
              fontFamily: 'Proxima',
              fontWeight: FontWeight.w700,
              fontSize: 34,
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
                  style: const TextStyle(
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
                    const Icon(Icons.remove_red_eye,
                        size: 16.0, color: Colors.black),
                    const SizedBox(width: 5.0),
                    const Text('100 views',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Proxima')),
                    const SizedBox(width: 15.0),
                    const Icon(Icons.date_range,
                        size: 16.0, color: Colors.black),
                    const SizedBox(width: 5.0),
                    const Text('Dec 25, 2023',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Proxima')),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isFollowed = !isFollowed;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(80, 30),
                        backgroundColor: const Color(0xFF196DFF),
                      ),
                      child: Text(
                        isFollowed ? 'Followed' : 'Follow',
                        style: const TextStyle(
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.newsTile.publisher,
                      style: const TextStyle(
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
                  style: const TextStyle(fontSize: 16.0, fontFamily: 'Proxima'),
                ),
              ),
              const SizedBox(height: 25.0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: const BoxDecoration(
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
                    _buildActionButton(
                        Icons.thumb_up, 'Like', Colors.black, () {}),
                    _buildActionButton(
                        Icons.comment, 'Comment', Colors.black, () {}),
                    _buildActionButton(
                        Icons.message, 'Message', const Color(0xFF196DFF), () {
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
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Community()));
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MarketPlace()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserAccount()));
          }
        },
      ),
    );
  }
}
