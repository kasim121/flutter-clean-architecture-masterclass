import 'package:demoapica/features/post/presentaion/bloc/bloc.dart';
import 'package:demoapica/features/post/presentaion/bloc/event.dart';
import 'package:demoapica/features/post/presentaion/bloc/state.dart';
import 'package:demoapica/features/post/presentaion/pages/postdetails/post_detail_bloc_version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PostBlocPage extends StatefulWidget {
  const PostBlocPage({super.key});

  @override
  State<PostBlocPage> createState() => _PostBlocPageState();
}

class _PostBlocPageState extends State<PostBlocPage> {
  @override
  void initState() {
    super.initState();

    context.read<PostBloc>().add(FetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),

      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PostError) {
            return Center(child: Text(state.message));
          }

          if (state is PostLoaded) {
            final posts = state.posts;

            return ListView.builder(
              itemCount: posts.length,

              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  margin: const EdgeInsets.all(8),

                  child: InkWell(
                    onTap: () {
                      // For demo: navigate to detail page using post id
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PostDetailBlocPage(id: post.id),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(post.title),

                      subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),

                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          const Icon(Icons.article, color: Colors.blue),

                          Text('#${post.id}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
