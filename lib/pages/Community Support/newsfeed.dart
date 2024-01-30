import 'package:flutter/material.dart';
import 'package:lawod/components/bottomnav.dart';
import 'package:lawod/pages/Community%20Support/community.dart';
import 'package:lawod/pages/Community%20Support/createpost.dart';
import 'package:lawod/pages/Marketplace/Marketplace%20Seller/user_account.dart';
import 'package:lawod/pages/Marketplace/marketplace.dart';
import 'newsdetails.dart';
import 'chat.dart';

class NewsTile {
  final String title;
  final String imagePath;
  final String publisher;
  final String description;
  bool isFollowed;

  NewsTile({
    required this.title,
    required this.imagePath,
    required this.publisher,
    required this.description,
    this.isFollowed = false,
  });
}

final List<NewsTile> newsTiles = [
  NewsTile(
    title:
        'Marcos wants PH NewsFeederies code amendment to protect NewsFeederfolk, resources',
    imagePath: 'assets/images/communitysupport/newsfeed/news1.png',
    publisher: 'Rappler',
    description:
        'Some NewsFeederfolk oppose the proposed amendments, saying efforts should be focused on evaluating the implementation of the law MANILA, Philippines – President Ferdinand Marcos Jr. on Monday, July 24, urged Congress to support his plan to revise the Republic Act No. 10654 or the amended NewsFeederies Code to “protect both the interests of our NewsFeederfolk and our NewsFeederies and aquatic resources.” Marcos, who said this in his second State of the Nation Address (SONA), is hopeful that introducing amendments to the law would make it more science-based but did not specify the revisions that should be made to achieve this. “We will seek the support of Congress to amend the Code to guarantee sustainable development of our NewsFeederies sector in harmony with environmental balance,” he said. \nThe NewsFeederies Code was first amended in 2014 to “prevent, deter, and eliminate illegal, unreported and unregulated NewsFeeding.”',
  ),
  NewsTile(
    title: 'NewsFeed catch down 70 percent; destruction of corals blamed',
    imagePath: 'assets/images/communitysupport/newsfeed/news2.png',
    publisher: 'PhilStar',
    description:
        'MANILA, Philippines — NewsFeed catch in the West Philippine Sea has gone down by 70 percent since 2020, and further decline is expected amid reports of massive poaching of corals by the Chinese, a militant NewsFeeders’ group warned yesterday. Pambansang Lakas ng Kilusang Mamamalakaya ng Pilipinas (Pamalakaya) national chairman Fernando Hicap raised the warning in a radio interview, in the wake of reports of plunder of corals in Rozul Reef, believed perpetrated by the Chinese. Corals are breeding grounds for marine life.',
  ),
  NewsTile(
    title:
        'PHL NewsFeederies get sustainability boost from Better Seafood Philippines and Mayani',
    imagePath: 'assets/images/communitysupport/newsfeed/news3.png',
    publisher: 'Business Mirror',
    description:
        'Small-scale NewsFeederies account for about half of the world’s seafood catch and 90% of its industry workers. In the context of the Philippines, over 1.9 million people rely on the NewsFeeding sector as their source of livelihood with a vast number of coastal communities considering it as part of their cultural fabric, identity, and economic kinship. \nDespite being one of the world’s largest seafood producers and a center of marine biodiversity, the Philippine seafood value chain is marred by a lot of challenges particularly from illegal, unreported, and unregulated (IUU) NewsFeeding. In 2019, over 40% of the country’s wild caught seafood came from IUU. This is according to Better Seafood Philippines, a USAID-funded program that aims to transform the Philippine seafood market by ensuring legal compliance to NewsFeedery laws, and empowering small-scale NewsFeeders to meet the growing demand for responsibly-sourced seafood.',
  ),
  NewsTile(
    title: 'NewsFeed supply enough, DA BFAR assures public',
    imagePath: 'assets/images/communitysupport/newsfeed/news4.png',
    publisher: 'Philippine Information Agency',
    description:
        'QUEZON CITY, (PIA) --The Department of Agriculture-Bureau of NewsFeederies and Aquatic Resources (DA-BFAR) has assured the public of adequate NewsFeed supply as the Holy Week nears when demand for NewsFeed increases, despite challenges on the food supply chain. DA-BFAR spokesperson Nazario Briguera said in a media briefing on Wednesday, March 15 that the Bureau is confident of sufficient production because NewsFeeding grounds in the country have reopened after its periodic closure that allowed NewsFeed species to reproduce. \n“Dahil nasa peak season tayo ngayon ng NewsFeeding activity, we expect na kaya nating punan ‘yung supply kahit tumaas ang demand sa Mahal na Araw (We are in the peak season of NewsFeeding activity, so we expect to meet the high demand for NewsFeed during the Holy Week),” he told reporters. \nBriguera meanwhile noted that the DA-BFAR acknowledges some factors that may affect local NewsFeed production, including the unprecedented oil spill in Mindoro. He said there could be lower NewsFeed output in Oriental Mindoro and nearby provinces following the continuous leakage of industrial oil from the sunken MT Princess Empress.',
  ),
  NewsTile(
    title: 'Filipinos NewsFeeding on the frontline of the West Philippine Sea',
    imagePath: 'assets/images/communitysupport/newsfeed/news5.png',
    publisher: 'GMA Network',
    description:
        'INFANTA, Pangasinan — NewsFeederman Mariel Villamonte had spent years plying the turquoise waters of Scarborough Shoal in the West Philippine Sea for snapper and grouper—until a Chinese coast guard vessel water cannoned his boat. That was in 2012, around the time China snatched control of the small ring of reefs from the Philippines, and he has not dared go back. "Their ships are made of steel, ours are made of wood," said Villamonte, now 31, recalling how two Chinese vessels chased his outrigger before blasting it with high-pressure water. The NewsFeeding ground, tapped by generations of Filipinos, is one of many potential flashpoints for military conflict over the South China Sea. \nChina and Taiwan both claim sovereignty over almost the entire sea, while the Philippines, Vietnam, Malaysia and Brunei have competing claims to parts of it. The Philippines calls the section of the sea in its exclusive economic zone and continental shelf the West Philippine Sea.',
  ),
];

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final int _currentIndex = 0;

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
    return ListView.builder(
      itemCount: newsTiles.length,
      itemBuilder: (BuildContext context, int index) {
        final newsTile = newsTiles[index];

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsDetailPage(newsTile)),
                  );
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          newsTile.imagePath,
                          width: MediaQuery.of(context).size.width,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                      const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye, size: 16.0),
                            SizedBox(width: 5.0),
                            Text('100 views'),
                            SizedBox(width: 15.0),
                            Icon(Icons.date_range, size: 16.0),
                            SizedBox(width: 5.0),
                            Text('Dec 25, 2023'),
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
                                      fontFamily: 'Proxima'),
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
                                              organizationName:
                                                  newsTile.publisher,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(80, 30),
                                        backgroundColor:
                                            const Color(0xFF196DFF),
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
                    ])));
      },
    );
  }
}
