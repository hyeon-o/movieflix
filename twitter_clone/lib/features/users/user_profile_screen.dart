import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/constants/gaps.dart';
import 'package:twitter_clone/constants/sizes.dart';
import 'package:twitter_clone/features/settings/views/settings_screen.dart';
import 'package:twitter_clone/features/videos/video_recording_screen.dart';
import 'package:twitter_clone/features/users/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends StatefulWidget {
  final XFile? image;

  const UserProfileScreen({super.key, this.image});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                collapsedHeight: Sizes.size72,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.globe, size: Sizes.size24),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoRecordingScreen(),
                        ),
                      );
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.instagram,
                      size: Sizes.size24,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsScreen(),
                        ),
                      );
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.alignRight,
                      size: Sizes.size24,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jane",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Gaps.v4,
                            Text(
                              "jane_mobbin",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Gaps.v4,
                            Text(
                              "Plant enthusiast!",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Gaps.v6,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Sizes.size20,
                              ),
                              child: Text(
                                "2 followers",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: Sizes.size12),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: widget.image != null
                              ? FileImage(File(widget.image!.path))
                              : AssetImage("assets/images/placeholder.png")
                                    as ImageProvider,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Edit Profile"),
                        ),
                      ),
                      Gaps.h16,
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Share Profile"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentTabBar(),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                  vertical: Sizes.size12,
                ),
                children: [
                  for (var i = 0; i < 10; i++)
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade300,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
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
                                    "jane_mobbin",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "5h",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      Gaps.h16,
                                      Icon(
                                        Icons.more_horiz,
                                        size: Sizes.size20,
                                        color: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.color!,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: Sizes.size14,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.color!,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Sizes.size14,
                                  ),
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.heart,
                                          size: Sizes.size24,
                                        ),
                                        Gaps.h16,
                                        FaIcon(
                                          FontAwesomeIcons.comment,
                                          size: Sizes.size24,
                                        ),
                                        Gaps.h16,
                                        FaIcon(
                                          FontAwesomeIcons.retweet,
                                          size: Sizes.size24,
                                        ),
                                        Gaps.h16,
                                        FaIcon(
                                          FontAwesomeIcons.paperPlane,
                                          size: Sizes.size24,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                  vertical: Sizes.size12,
                ),
                children: [
                  for (var i = 0; i < 10; i++)
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade300,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
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
                                    "jane_mobbin",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "5h",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      Gaps.h16,
                                      Icon(
                                        Icons.more_horiz,
                                        size: Sizes.size20,
                                        color: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.color!,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: Sizes.size14,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.color!,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Sizes.size14,
                                  ),
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.heart,
                                          size: Sizes.size24,
                                        ),
                                        Gaps.h16,
                                        FaIcon(
                                          FontAwesomeIcons.comment,
                                          size: Sizes.size24,
                                        ),
                                        Gaps.h16,
                                        FaIcon(
                                          FontAwesomeIcons.retweet,
                                          size: Sizes.size24,
                                        ),
                                        Gaps.h16,
                                        FaIcon(
                                          FontAwesomeIcons.paperPlane,
                                          size: Sizes.size24,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}
