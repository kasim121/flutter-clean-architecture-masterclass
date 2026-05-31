import 'package:demoapica/features/post/data/models/response.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();

  // Fetch detail for a single post by id.
  Future<Post> getPostDetail(String id);
}