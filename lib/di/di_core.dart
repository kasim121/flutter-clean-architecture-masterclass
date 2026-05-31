// This file contains the core dependency injection setup using GetIt for the
// Post app. It registers data sources, repositories, and use cases that
// are shared across the app and used by different state-management approaches
// (Bloc / Provider / Riverpod).
//
// Best practices applied here:
// - Register low-level, stateless services as singletons (lazy) so they are
//   shared across the app.
// - Register by interface (e.g. `PostRepository`) so tests can easily
//   override implementations.
// - Keep stateful objects (Blocs / ChangeNotifiers / Notifiers) in per-approach
//   DI modules using `registerFactory` so a fresh instance can be created per
//   UI scope.

import 'package:get_it/get_it.dart';

// Shared imports
import '../features/post/data/datasource/post_remote_datasource.dart';
import '../features/post/data/repository/post_repository_impl.dart';
import '../features/post/domain/repository/post_repository.dart';
import '../features/post/domain/usecases/get_usecase.dart';

/// GetIt service locator shared instance
final sl = GetIt.instance;

/// Core registrations used by all state-management approaches (Bloc / Provider / Riverpod).
Future<void> initCore() async {
  // Data sources
  if (!sl.isRegistered<PostRemoteDataSource>()) {
    sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(),
    );
  }

  // Repositories (registered by interface). Use explicit typed lookups for clarity.
  if (!sl.isRegistered<PostRepository>()) {
    sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(sl<PostRemoteDataSource>()),
    );
  }

  // Use cases (stateless): lazy singletons are fine.
  if (!sl.isRegistered<GetPosts>()) {
    sl.registerLazySingleton<GetPosts>(
      () => GetPosts(sl<PostRepository>()),
    );
  }

  if (!sl.isRegistered<GetPostDetail>()) {
    sl.registerLazySingleton<GetPostDetail>(
      () => GetPostDetail(sl<PostRepository>()),
    );
  }

  // Note: register Blocs/Providers/Notifiers in their respective di_* files using registerFactory.
  // This keeps core focused on shared, stateless services and makes testing easier.
}
