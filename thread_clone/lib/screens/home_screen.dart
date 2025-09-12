import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/providers/home_threads_provider.dart';
import 'package:thread_clone/utils/show_message_utils.dart';
import 'package:thread_clone/widgets/safe_padding.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routePath = '/home';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final threads = ref.watch(homeThreadsProvider);

    return Scaffold(
      body: SafePadding(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CupertinoSearchTextField(
                controller: _searchController,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    ref.read(homeThreadsProvider.notifier).searchThreads(
                      value,
                      true,
                      () {
                        ShowMessageUtils.showErrorMessage(
                          context,
                          '검색 중 오류가 발생했습니다.',
                        );
                      },
                    );
                  }
                },
                onSuffixTap: () {
                  _searchController.clear();
                  ref.invalidate(homeThreadsProvider);
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            if (threads.hasValue)
              SliverList.separated(
                separatorBuilder: (_, __) => Divider(),
                itemCount: threads.value!.length,
                itemBuilder: (_, int index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      threads.value![index].email,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(threads.value![index].content),
                    const SizedBox(height: 12),
                    if (threads.value![index].imageUrls.isNotEmpty)
                      SizedBox(
                        height: 80,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 8,
                            children: threads.value![index].imageUrls
                                .map(
                                  (imageUrl) => Image(
                                    image: NetworkImage(imageUrl),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
