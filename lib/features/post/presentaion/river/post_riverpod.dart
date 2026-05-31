import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demoapica/features/post/data/models/response.dart';
class PostState {
  final bool loading;
  final List<Post>? posts;
  final String? error;

  // Detail state
  final Post? selectedPost;
  final bool detailLoading;
  final String? detailError;

  PostState({this.loading = false, this.posts, this.error, this.selectedPost, this.detailLoading = false, this.detailError});

  PostState copyWith({bool? loading, List<Post>? posts, String? error, Post? selectedPost, bool? detailLoading, String? detailError}) {
    return PostState(
      loading: loading ?? this.loading,
      posts: posts ?? this.posts,
      error: error ?? this.error,
      selectedPost: selectedPost ?? this.selectedPost,
      detailLoading: detailLoading ?? this.detailLoading,
      detailError: detailError ?? this.detailError,
    );
  }
}

class PostNotifier extends StateNotifier<PostState> {
  final Future<List<Post>> Function() fetcher;
  final Future<Post> Function(String id)? detailFetcher;

  PostNotifier(this.fetcher, {this.detailFetcher}) : super(PostState());

  Future<void> fetchPosts() async {
    state = state.copyWith(loading: true);
    try {
      final posts = await fetcher();
      state = state.copyWith(loading: false, posts: posts, error: null);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<Post?> fetchPostDetail(String id) async {
    if (detailFetcher == null) throw Exception('Detail fetcher not provided');
    state = state.copyWith(detailLoading: true, detailError: null);
    try {
      final post = await detailFetcher!(id);
      state = state.copyWith(detailLoading: false, selectedPost: post, detailError: null);
      return post;
    } catch (e) {
      state = state.copyWith(detailLoading: false, detailError: e.toString());
      return null;
    }
  }
}
