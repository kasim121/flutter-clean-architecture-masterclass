import 'package:demoapica/features/post/presentaion/pages/postdetails/post_detail_provider_version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../river/post_riverpod.dart';


final PostNotifierProvider = StateNotifierProvider<PostNotifier, PostState>((ref) {
  // use instance from GetIt
  return GetIt.instance.get<PostNotifier>();
});

class PostRiverPage extends ConsumerStatefulWidget {
  const PostRiverPage({super.key});

  @override
  ConsumerState<PostRiverPage> createState() => _PostRiverPageState();
}

class _PostRiverPageState extends ConsumerState<PostRiverPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(PostNotifierProvider.notifier).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(PostNotifierProvider);

    if (state.loading) {
      return Scaffold(appBar: AppBar(title: const Text('Posts (Riverpod)')), body: const Center(child: CircularProgressIndicator()));
    }

    if (state.error != null) {
      return Scaffold(appBar: AppBar(title: const Text('Posts (Riverpod)')), body: Center(child: Text(state.error!)));
    }

    final posts = state.posts ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Posts (Riverpod)')),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PostDetailProviderPage(id: post.id)));
              },
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                trailing: Text('#${post.id}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
