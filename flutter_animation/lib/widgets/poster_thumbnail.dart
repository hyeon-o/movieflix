import 'package:flutter/material.dart';
import 'package:flutter_animation/data.dart';

class PosterThumbnail extends StatelessWidget {
  final int index;

  const PosterThumbnail({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(mockData[index].image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
