import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:twitter_clone/constants/sizes.dart';
import 'package:twitter_clone/features/users/user_profile_screen.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final XFile image;
  final bool isPicked;

  const VideoPreviewScreen({
    super.key,
    required this.image,
    required this.isPicked,
  });

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  bool _saveImage = false;

  void _saveToGallery() async {
    if (_saveImage) return;

    await SaverGallery.saveFile(
      filePath: widget.image.path,
      fileName: widget.image.path.split('/').last,
      androidRelativePath: "Pictures",
      skipIfExists: true,
    );

    _saveImage = true;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Preview Video'),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(
                _saveImage ? FontAwesomeIcons.check : FontAwesomeIcons.download,
                color: Colors.black,
              ),
            ),
        ],
      ),
      body: Image.file(File(widget.image.path)),
    );
  }
}
