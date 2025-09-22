import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/screens/home_screen.dart';
import 'package:mood_tracker/screens/post_screen.dart';

enum NavigationItem { home, post }

class NavigationLayout extends StatefulWidget {
  final NavigationItem item;
  const NavigationLayout({super.key, this.item = NavigationItem.home});

  @override
  State<NavigationLayout> createState() => _NavigationLayoutState();
}

class _NavigationLayoutState extends State<NavigationLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (widget.item == NavigationItem.home) ? const HomeScreen() : const PostScreen(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.item.index,
        onTap: (index) {
          if (index == NavigationItem.home.index) {
            context.go(HomeScreen.routePath);
          } else if (index == NavigationItem.post.index) {
            context.go(PostScreen.routePath);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Post'),
        ],
      ),
    );
  }
}
