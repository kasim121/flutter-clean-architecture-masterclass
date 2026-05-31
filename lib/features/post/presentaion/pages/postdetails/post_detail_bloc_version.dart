import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demoapica/features/post/presentaion/bloc/bloc.dart';
import 'package:demoapica/features/post/presentaion/bloc/event.dart';
import 'package:demoapica/features/post/presentaion/bloc/state.dart';
import 'package:demoapica/features/post/data/models/response.dart';

/// Bloc-based detail page that uses the app-scoped `PostBloc`.
class PostDetailBlocPage extends StatefulWidget {
  final int id;
  const PostDetailBlocPage({super.key, required this.id});

  @override
  State<PostDetailBlocPage> createState() => _PostDetailBlocPageState();
}

class _PostDetailBlocPageState extends State<PostDetailBlocPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Use the app-scoped PostBloc to fetch detail; no GetIt in UI.
      context.read<PostBloc>().add(FetchPostDetail(widget.id.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post detail (Bloc)')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostDetailLoading) return const Center(child: CircularProgressIndicator());
          if (state is PostDetailError) return Center(child: Text(state.message));
          if (state is PostDetailLoaded) {
            final Post post = state.post;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(post.body),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
