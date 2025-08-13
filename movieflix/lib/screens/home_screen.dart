import 'package:flutter/material.dart';
import 'package:movie/widgets/coming_soon_section.dart';
import 'package:movie/widgets/now_playing_section.dart';
import 'package:movie/widgets/popular_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              PopularSection(),
              SizedBox(height: 20),
              NowPlayingSection(),
              SizedBox(height: 16),
              ComingSoonSection(),
            ],
          ),
        ),
      ),
    );
  }
}
