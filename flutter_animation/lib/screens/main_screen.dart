import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animation/data.dart';
import 'package:flutter_animation/widgets/poster_background.dart';
import 'package:flutter_animation/widgets/poster_detail.dart';
import 'package:flutter_animation/widgets/poster_information.dart';
import 'package:flutter_animation/widgets/poster_thumbnail.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late final AnimationController _animationController = AnimationController(
    duration: Duration(milliseconds: 500),
    reverseDuration: Duration(milliseconds: 300),
    vsync: this,
  );

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade500,
        body: Stack(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: PosterBackground(index: _currentIndex),
            ),
            SizedBox(
                  width: size.width,
                  height: size.height,
                  child: PosterDetail(index: _currentIndex),
                )
                .animate(autoPlay: false, controller: _animationController)
                .slideY(begin: -1, end: 0),
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: mockData.length,
              itemBuilder: (context, index) => GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    _animationController.forward();
                  }
                },
                child: Stack(
                  children: [
                    Positioned(
                          top: 170,
                          width: size.width,
                          child: Align(
                            alignment: Alignment.center,
                            child: PosterInformation(index: index),
                          ),
                        )
                        .animate(
                          autoPlay: false,
                          controller: _animationController,
                        )
                        .slideY(begin: 0, end: 1),
                    Positioned(
                          top: 70,
                          width: size.width,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: PosterThumbnail(index: index),
                          ),
                        )
                        .animate(
                          autoPlay: false,
                          controller: _animationController,
                        )
                        .slideY(begin: 0, end: 3),
                  ],
                ),
              ),
            ),
            Positioned(
                  top: 0,
                  width: size.width,
                  height: 70,
                  child: Center(
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                )
                .animate(autoPlay: false, controller: _animationController)
                .fadeOut(),
            Positioned(
                  bottom: 40,
                  width: size.width,
                  height: 70,
                  child: GestureDetector(
                    onTap: () {
                      _animationController.reverse();
                    },
                    child: Center(
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                )
                .animate(autoPlay: false, controller: _animationController)
                .fadeIn(),
          ],
        ),
      ),
    );
  }
}
