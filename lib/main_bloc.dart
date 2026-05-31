import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'di/di_bloc.dart' as di;
import 'features/post/presentaion/pages/post/post_bloc_page.dart';
import 'features/post/presentaion/bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initBloc();

  final sl = GetIt.instance;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(
          create: (_) => sl.get<PostBloc>(),
        ),
        // Add more app-scoped blocs here as needed
      ],
      child: const MyBlocApp(),
    ),
  );
}


class MyBlocApp extends StatelessWidget {
  const MyBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo - Bloc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PostBlocPage(),
    );
  }
}

/* =====================================================
   ALTERNATIVE (No DI) - Full standalone main (Bloc, commented)

   // Copy this entire block and uncomment to run the app without GetIt/DI.

   import 'package:flutter/material.dart';
   import 'package:flutter_bloc/flutter_bloc.dart';
   import 'features/post/data/datasource/post_remote_datasource.dart';
   import 'features/post/data/repository/post_repository_impl.dart';
   import 'features/post/domain/usecases/get_usecase.dart';
   import 'features/post/presentaion/bloc/bloc.dart';
   import 'features/post/presentaion/pages/post/post_bloc_page.dart';

   void main() {
     WidgetsFlutterBinding.ensureInitialized();

     // 1) Create concrete instances (no central DI)
     final postRemote = PostRemoteDataSourceImpl();
     final postRepo = PostRepositoryImpl(postRemote);
     final getPosts = GetPosts(postRepo);
     final getPostDetail = GetPostDetail(postRepo);

     // 2) Compose the bloc in the widget tree using the concrete instances
     runApp(
       MultiBlocProvider(
         providers: [
           BlocProvider<PostBloc>(
             create: (_) => PostBloc(getPosts, getPostDetail),
           ),
         ],
         child: const MyBlocAppNoDi(),
       ),
     );
   }

   /// A full MyApp variant to run without DI. It intentionally uses the same
   /// UI (`PostBlocPage`) so you can swap mains quickly.
   class MyBlocAppNoDi extends StatelessWidget {
     const MyBlocAppNoDi({super.key});

     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         title: 'Demo - Bloc (No DI)',
         theme: ThemeData(
           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
         ),
         home: const PostBlocPage(),
       );
     }
   }

   Notes:
   - This block is entirely self-contained: imports, main, and MyApp class.
   - To run without DI: replace the real `main()` in this file with the
     above `main()` (or copy this file and uncomment the block).
   - After testing, revert to the DI-based `main` for scalable apps.
   ===================================================== */