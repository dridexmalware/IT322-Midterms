import 'package:flutter/material.dart';
import 'package:lawod/components/bottomnav.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_account.dart';
import 'package:lawod/pages/Marketplace/marketplace.dart';
import 'chat.dart';
import 'package:lawod/pages/Community Support/community.dart';


class DirectoryListScreen extends StatefulWidget {
  const DirectoryListScreen({super.key});

  @override
  State<DirectoryListScreen> createState() => _DirectoryListScreenState();
}

class _DirectoryListScreenState extends State<DirectoryListScreen> {
  final int _currentIndex = 0;

  final List<String> organizations = [
    'BFAR Region X',
    'PAMALAKAYA-Pilipinas',
    'Agricultural Productivity Operations Office - Cagayan de Oro',
    'Local Government Unit of Alubijid',
    'Local Government Unit of El Salvador',
    'Local Government Unit of Opol',
  ];

  final List<String> addresses = [
    'Julio Pacana St., Macabalan, Cagayan de Oro City',
    '56 K-9th Street, Brgy. West Kamias, Quezon City, Philippines',
    '2118 Thornridge Cir. Syracuse, Connecticut 35624',
    '9018 Misamis Oriental',
    '2118 Thornridge Cir. Syracuse, Connecticut 35624',
    '1901 Thornridge Cir. Shiloh, Hawaii 81063',
  ];

  final List<String> communitylogo = [
    'assets/images/communitysupport/communitylogo/BFAR.png',
    'assets/images/communitysupport/communitylogo/PAMALAKAYA.png',
    'assets/images/communitysupport/communitylogo/APOO.png',
    'assets/images/communitysupport/communitylogo/LGUalub.png',
    'assets/images/communitysupport/communitylogo/LGUelsal.png',
    'assets/images/communitysupport/communitylogo/LGUopol.png',
  ];

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
            'Directory',
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
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: ListView.builder(
          itemCount: organizations.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                ListTile(
                  leading: Image.asset(
                    communitylogo[index],
                    width: 40,
                    height: 40,
                  ),
                  title: Text(
                    organizations[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Proxima',
                    ),
                  ),
                  subtitle: Text(
                    addresses[index],
                    style: const TextStyle(fontFamily: 'Proxima'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          organizationName: organizations[index],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
              ],
            );
          },
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
