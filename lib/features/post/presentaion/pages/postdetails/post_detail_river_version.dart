import 'package:demoapica/features/post/presentaion/pages/post/post_river_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PostDetailRiverPage extends ConsumerStatefulWidget {
  final int id;
  const PostDetailRiverPage({super.key, required this.id});

  @override
  ConsumerState<PostDetailRiverPage> createState() => _PostDetailRiverPageState();
}

class _PostDetailRiverPageState extends ConsumerState<PostDetailRiverPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Trigger the app-scoped notifier to fetch the detail.
      ref.read(PostNotifierProvider.notifier).fetchPostDetail(widget.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(PostNotifierProvider);
    final post = state.selectedPost;

    return Scaffold(
      appBar: AppBar(title: Text('Post detail #${widget.id} (Riverpod)')),
      body: Center(
        child: state.detailLoading
            ? const CircularProgressIndicator()
            : state.detailError != null
                ? Text(state.detailError!)
                : post == null
                    ? const Text('No data')
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.title, style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 8),
                            Text(post.body),
                          ],
                        ),
                      ),
      ),
    );
  }
}
