import 'package:flutter/material.dart';
import 'package:demoapica/features/post/data/models/response.dart';


enum ProviderStatus { initial, loading, loaded, error }

class PostProvider extends ChangeNotifier {
  // A generic fetcher function returning a Future<List<Post>>. This allows
  // switching the underlying API implementation at runtime (usecases,
  // repository, or datasource) for testing different state-management flows.
  final Future<List<Post>> Function() fetcher;

  // Optional detail fetcher: returns a single Post given an id (as String).
  final Future<Post> Function(String id)? detailFetcher;

  ProviderStatus status = ProviderStatus.initial;
  List<Post>? posts;
  String? message;

  // Detail state
  Post? selectedPost;
  bool detailLoading = false;
  String? detailError;

  PostProvider(this.fetcher, {this.detailFetcher});

  Future<void> fetchPosts() async {
    status = ProviderStatus.loading;
    notifyListeners();

    try {
      posts = await fetcher();
      status = ProviderStatus.loaded;
    } catch (e) {
      message = e.toString();
      status = ProviderStatus.error;
    }

    notifyListeners();
  }

  Future<Post?> fetchPostDetail(int id) async {
    if (detailFetcher == null) {
      throw Exception('Detail fetcher not provided');
    }

    detailLoading = true;
    detailError = null;
    notifyListeners();

    try {
      final post = await detailFetcher!(id.toString());
      selectedPost = post;
      return post;
    } catch (e) {
      detailError = e.toString();
      return null;
    } finally {
      detailLoading = false;
      notifyListeners();
    }
  }
}
