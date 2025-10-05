import 'package:flutter/material.dart';
import 'package:flutter_animation/data.dart';

class PosterDetail extends StatelessWidget {
  final int index;

  const PosterDetail({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: 40,
      ),
      child: Column(
        children: [
          Text(
            mockData[index].title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Colors.white.withAlpha(100),
            height: 50,
            thickness: 1.5,
          ),
          Text(
            mockData[index].description,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
