import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demoapica/features/post/presentaion/provider/post_provider.dart';
import 'package:demoapica/features/post/data/models/response.dart';

/// Detail page that uses the app-scoped `PostProvider` (provided via MultiProvider).
class PostDetailProviderPage extends StatefulWidget {
  final int id;
  const PostDetailProviderPage({super.key, required this.id});

  @override
  State<PostDetailProviderPage> createState() => _PostDetailProviderPageState();
}

class _PostDetailProviderPageState extends State<PostDetailProviderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Trigger the app-scoped provider to fetch the detail. The provider must have
      // been registered with a detailFetcher in DI (or an exception will be thrown).
      try {
        context.read<PostProvider>().fetchPostDetail(widget.id);
      } catch (_) {
        // ignore - provider may not have detailFetcher; UI will show error state.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PostProvider>();
    final Post? post = vm.selectedPost;

    return Scaffold(
      appBar: AppBar(title: Text('Post detail #${widget.id} (Provider)')),
      body: Center(
        child: vm.detailLoading
            ? const CircularProgressIndicator()
            : vm.detailError != null
                ? Text(vm.detailError!)
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
