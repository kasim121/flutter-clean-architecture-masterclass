import 'package:get_it/get_it.dart';
import 'di_core.dart';
import '../features/post/presentaion/provider/post_provider.dart';
import '../features/post/domain/usecases/get_usecase.dart';


Future<void> initProviderDI() async {
  await initCore();

  final sl = GetIt.instance;
  if (!sl.isRegistered<PostProvider>()) {
    // Register factory so each ChangeNotifier provider gets a fresh instance.
    sl.registerFactory<PostProvider>(
      () => PostProvider(
        sl<GetPosts>().call1,
        detailFetcher: sl<GetPostDetail>().call2,
      ),
    );
  }
}


