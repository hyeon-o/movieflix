import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/sizes.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: TabBar(
        padding: EdgeInsets.only(top: Sizes.size10),
        tabs: [
          Tab(text: "Threads"),
          Tab(text: "Replies"),
        ],
        labelColor: Theme.of(context).textTheme.bodyLarge!.color!,
        unselectedLabelColor: Colors.grey.shade500,
        labelPadding: EdgeInsets.symmetric(vertical: Sizes.size10),
        indicatorColor: Theme.of(context).textTheme.bodyLarge!.color!,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
    );
  }
  
  @override
  double get maxExtent => 56;
  
  @override
  double get minExtent => 56;
  
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
