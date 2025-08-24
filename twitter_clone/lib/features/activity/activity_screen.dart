import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/gaps.dart';
import 'package:twitter_clone/constants/sizes.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: Sizes.size80,
          title: Text(
            'Activity',
            style: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size44,
              fontWeight: FontWeight.w800,
            ),
          ),
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(Sizes.size16),
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            dividerHeight: 0,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Replies'),
              Tab(text: 'Mentions'),
              Tab(text: 'Views'),
              Tab(text: 'Likes'),
              Tab(text: 'Media'),
              Tab(text: 'Follows'),
              Tab(text: 'Retweets'),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size16,
            vertical: Sizes.size12,
          ),
          children: [
            for (var i = 0; i < 10; i++)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: Sizes.size12),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            'https://picsum.photos/200/300',
                          ),
                        ),
                        Positioned(
                          top: Sizes.size24,
                          right: -Sizes.size4,
                          child: Container(
                            padding: EdgeInsets.all(Sizes.size4),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '@',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.h16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: RichText(
                            text: TextSpan(
                              text: 'John Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Sizes.size16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: ' 4h',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Sizes.size14,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            'Mentioned you',
                            style: TextStyle(
                              fontSize: Sizes.size14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.size28,
                                vertical: Sizes.size6,
                              ),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Sizes.size16,
                                ),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Text(
                              'Following',
                              style: TextStyle(
                                fontSize: Sizes.size14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Sizes.size14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
