import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'di_core.dart';
import '../features/post/presentaion/river/post_riverpod.dart';
import '../features/post/domain/usecases/get_usecase.dart';

/// Initialize core (GetIt) registrations used by Riverpod providers.
/// Keeps parity with other DI modules but does NOT register Riverpod notifiers
/// in GetIt — Riverpod will construct notifiers so lifecycle and overrides work.
Future<void> initRiverpodDI() async {
  await initCore();
}

/// Small Riverpod providers that expose the core usecases.
/// These read the GetIt-registered singletons so tests can still override
/// providers via `ProviderScope(overrides: [...])` when needed.
final getPostsProvider = Provider<GetPosts>((ref) {
  return GetIt.instance<GetPosts>();
});

final getPostDetailProvider = Provider<GetPostDetail>((ref) {
  return GetIt.instance<GetPostDetail>();
});

/// Pure-Riverpod wiring: construct the PostNotifier here so tests
/// can override `PostNotifierProvider` in `ProviderScope` without
/// touching GetIt. Use the usecase `.call` method directly for clarity.
final postNotifierProvider = StateNotifierProvider<PostNotifier, PostState>((ref) {
  final getPosts = ref.read(getPostsProvider);
  final getPostDetail = ref.read(getPostDetailProvider);
  return PostNotifier(getPosts.call1, detailFetcher: getPostDetail.call2);
});
