import 'package:demoapica/features/post/data/models/response.dart';
import 'package:demoapica/features/post/domain/repository/post_repository.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

  Future<List<Post>> call1() {
    return repository.getPosts();
  }
}

class GetPostDetail {
  final PostRepository repository;

  GetPostDetail(this.repository);

  Future<Post> call2(String id) {
    return repository.getPostDetail(id);
  }
}