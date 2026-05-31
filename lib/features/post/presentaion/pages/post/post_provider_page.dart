import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demoapica/features/post/presentaion/provider/post_provider.dart';
import '../postdetails/post_detail_provider_version.dart';

class PostProviderPage extends StatefulWidget {
 
  const PostProviderPage({super.key,});

  @override
  State<PostProviderPage> createState() => _PostProviderPageState();
}

class _PostProviderPageState extends State<PostProviderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<PostProvider>().fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Provider is expected to be provided above (in main). Do not create it here.
    return Scaffold(
      appBar: AppBar(title: const Text('Posts (Provider)')),
      body: Consumer<PostProvider>(builder: (context, provider, _) {
        // Fetch is triggered in initState.

        switch (provider.status) {
          case ProviderStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case ProviderStatus.error:
            return Center(child: Text(provider.message ?? 'Unknown error'));

          case ProviderStatus.loaded:
            final posts = provider.posts ?? [];
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PostDetailProviderPage(
                            id: post.id,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                      trailing: Text('#${post.id}'),
                    ),
                  ),
                );
              },
            );

          case ProviderStatus.initial:
            return const SizedBox();
        }
      }),
    );
  }
}
