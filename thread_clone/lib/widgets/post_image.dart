import 'dart:io';
import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  final String imagePath;
  final Function() onDelete;

  const PostImage({super.key, required this.imagePath, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: FileImage(File(imagePath)),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: onDelete,
            child: Container(
              color: Colors.black54,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}