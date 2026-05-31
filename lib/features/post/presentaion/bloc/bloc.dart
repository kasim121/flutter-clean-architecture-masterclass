import 'package:bloc/bloc.dart';
import 'package:demoapica/features/post/domain/usecases/get_usecase.dart';
import 'package:demoapica/features/post/presentaion/bloc/event.dart';
import 'package:demoapica/features/post/presentaion/bloc/state.dart';

class PostBloc
    extends Bloc<PostEvent, PostState> {

  final GetPosts getPosts;
  final GetPostDetail getPostDetail;

  PostBloc(this.getPosts, this.getPostDetail)
      : super(PostInitial()) {

    on<FetchPosts>(_fetchPost);
    on<FetchPostDetail>(_fetchPostDetail);
  }

  Future<void> _fetchPost(
    FetchPosts event,
    Emitter<PostState> emit,
  ) async {

    emit(PostLoading());

    try {

      final posts = await getPosts.call1();

      emit(
        PostLoaded(posts),
      );

    } catch (e) {

      emit(
        PostError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _fetchPostDetail(
    FetchPostDetail event,
    Emitter<PostState> emit,
  ) async {
    emit(PostDetailLoading());

    try {
      final post = await getPostDetail.call2(event.id);
      emit(PostDetailLoaded(post));
    } catch (e) {
      emit(PostDetailError(e.toString()));
    }
  }
}