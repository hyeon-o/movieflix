import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animation/data.dart';

class PosterBackground extends StatelessWidget {
  final int index;

  const PosterBackground({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(index),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(mockData[index].image),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(color: Colors.black.withAlpha(120)),
      ),
    );
  }
}
