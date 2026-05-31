import 'package:get_it/get_it.dart';
import 'di_core.dart';
import '../features/post/presentaion/bloc/bloc.dart';
import '../features/post/domain/usecases/get_usecase.dart';

Future<void> initBloc() async {
  await initCore();

  final sl = GetIt.instance;
  if (!sl.isRegistered<PostBloc>()) {
    // Register as factory so each Bloc consumer gets a fresh instance.
    sl.registerFactory<PostBloc>(
      () => PostBloc(sl<GetPosts>(), sl<GetPostDetail>()),
    );
  }
}