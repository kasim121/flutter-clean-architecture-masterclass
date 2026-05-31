import 'dart:convert';
import 'package:demoapica/features/post/data/models/response.dart';
import 'package:http/http.dart' as http;
import 'package:demoapica/core/constants/constants.dart';




abstract class PostRemoteDataSource {
  Future<List<Post>> getPosts();

  Future<Post> getPostDetail(String id);
}

class PostRemoteDataSourceImpl
    implements PostRemoteDataSource {

  @override
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(AppConstants.postsUrl));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
    }

    throw Exception('Failed to load posts: ${response.statusCode}');
  }

  @override
  Future<Post> getPostDetail(String id) async {
    final uri = Uri.parse('${AppConstants.postsUrl}/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }

    throw Exception('Failed to load detail: ${response.statusCode}');
  }
}