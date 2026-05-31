import 'package:demoapica/features/post/data/datasource/post_remote_datasource.dart';
import 'package:demoapica/features/post/data/models/response.dart';
import 'package:demoapica/features/post/domain/repository/post_repository.dart';

class PostRepositoryImpl
    implements PostRepository {

  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<List<Post>> getPosts() async {
    return await remoteDataSource.getPosts();
  }

  @override
  Future<Post> getPostDetail(String id) async {
    return await remoteDataSource.getPostDetail(id);
  }
}