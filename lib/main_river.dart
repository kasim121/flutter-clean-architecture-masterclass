import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'di/di_riverpod.dart' as di;
import 'features/post/presentaion/pages/post/post_river_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initRiverpodDI();

  runApp(
    ProviderScope(
      child: const MyRiverApp(),
    ),
  );
}

class MyRiverApp extends StatelessWidget {
  const MyRiverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo - Riverpod',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PostRiverPage(),
    );
  }
}

/* =====================================================
   ALTERNATIVE (No DI) - Full standalone main (Riverpod, commented)

   // Copy this entire block and uncomment to run the app without GetIt/DI.

   import 'package:flutter/material.dart';
   import 'package:flutter_riverpod/flutter_riverpod.dart';
   import 'features/post/data/datasource/post_remote_datasource.dart';
   import 'features/post/data/repository/post_repository_impl.dart';
   import 'features/post/domain/usecases/get_usecase.dart';
   import 'features/post/presentaion/river/post_riverpod.dart';
   import 'features/post/presentaion/pages/post/post_river_page.dart';

   void main() {
     WidgetsFlutterBinding.ensureInitialized();

     // 1) Create concrete instances (no central DI)
     final postRemote = PostRemoteDataSourceImpl();
     final postRepo = PostRepositoryImpl(postRemote);
     final getPosts = GetPosts(postRepo);
     final getPostDetail = GetPostDetail(postRepo);

     // 2) Create River providers that return the concrete usecases
     final getPostsProvider = Provider<GetPosts>((_) => getPosts);
     final getPostDetailProvider = Provider<GetPostDetail>((_) => getPostDetail);
     final postNotifierProvider = StateNotifierProvider<PostNotifier, PostState>((ref) => PostNotifier(getPosts.call, detailFetcher: getPostDetail.call));

     runApp(ProviderScope(child: const MyRiverAppNoDi()));
   }

   /// A full MyApp variant to run without DI. It intentionally uses the same
   /// UI (`PostRiverPage`) so you can swap mains quickly.
   class MyRiverAppNoDi extends StatelessWidget {
     const MyRiverAppNoDi({super.key});

     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         title: 'Demo - Riverpod (No DI)',
         theme: ThemeData(
           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
         ),
         home: const PostRiverPage(),
       );
     }
   }

   Notes:
   - This block is entirely self-contained: imports, main, and MyApp class.
   - To run without DI: replace the real `main()` in this file with the
     above `main()` (or copy this file and uncomment the block).
   - After testing, revert to the DI-based `main` for scalable apps.
   ===================================================== */
