abstract class PostEvent {}

class FetchPosts extends PostEvent {}

class FetchPostDetail extends PostEvent {
  final String id;
  FetchPostDetail(this.id);
}