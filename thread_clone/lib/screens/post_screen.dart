import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thread_clone/providers/post_provider.dart';
import 'package:thread_clone/providers/user_provider.dart';
import 'package:thread_clone/screens/home_screen.dart';
import 'package:thread_clone/utils/show_message_utils.dart';
import 'package:thread_clone/widgets/post_image.dart';
import 'package:thread_clone/widgets/safe_padding.dart';

class PostScreen extends ConsumerStatefulWidget {
  static const String routePath = '/post';

  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _textController = TextEditingController();

  final List<XFile> _images = [];

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _images.add(picked);
      });
    }
  }

  void _submitPost() {
    final text = _textController.text.trim();
    if (text.isEmpty && _images.isEmpty) {
      ShowMessageUtils.showInfoMessage(context, '글과 이미지를 작성해주세요.');
      return;
    }

    ref.read(postProvider.notifier).submitPost(
      text,
      _images.map((image) => File(image.path)).toList(),
      () {
        ShowMessageUtils.showInfoMessage(context, '게시물이 업로드되었습니다.');
        context.pushReplacement(HomeScreen.routePath);
      },
      (message) {
        ShowMessageUtils.showErrorMessage(context, message);
      }
    );
  }

  @override
  void dispose() {
    _images.clear();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Thread',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafePadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ref.watch(userProvider).value?.email ?? '',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _textController,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: '스레드를 시작하세요...',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 12),
            if (_images.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return PostImage(
                            imagePath: _images[index].path,
                            onDelete: () {
                              setState(() {
                                _images.removeAt(index);
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(width: 8),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.paperclip),
                  onPressed: _pickImage,
                ),
                FilledButton(onPressed: _submitPost, child: Text('게시')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
