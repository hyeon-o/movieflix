import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/gaps.dart';
import 'package:twitter_clone/constants/sizes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Sizes.size80,
        title: Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size44,
            fontWeight: FontWeight.w800,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.size44),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            child: const CupertinoSearchTextField(
              padding: EdgeInsets.symmetric(vertical: Sizes.size12),
            ),
          ),
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
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/200/300',
                    ),
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
                        title: Text(
                          'John Doe',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size16,
                          ),
                        ),
                        subtitle: Text(
                          'john.doe@example.com',
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
                              borderRadius: BorderRadius.circular(Sizes.size16),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          child: Text(
                            'Follow',
                            style: TextStyle(fontSize: Sizes.size14),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(
                              'https://picsum.photos/200/300',
                            ),
                          ),
                          Gaps.h10,
                          Text(
                            '24K followers',
                            style: TextStyle(
                              fontSize: Sizes.size14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
