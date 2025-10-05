import 'package:flutter/material.dart';
import 'package:flutter_animation/data.dart';

class PosterInformation extends StatelessWidget {
  final int index;

  const PosterInformation({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 620,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: 240),
            Text(
              '"${mockData[index].title}"',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              mockData[index].description,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
