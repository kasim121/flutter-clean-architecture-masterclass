/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'di/di_provider.dart' as di;
import 'package:get_it/get_it.dart';
import 'features/post/presentaion/provider/post_provider.dart';
import 'features/post/presentaion/pages/post/post_provider_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initProviderDI();

  final sl = GetIt.instance;


  runApp(
    // Provide a top-level MultiProvider to supply app-scoped providers.
    MultiProvider(
      providers: [
        // Create the ChangeNotifierProvider here using the DI-registered factory.
        ChangeNotifierProvider<PostProvider>(
          create: (_) => sl.get<PostProvider>(),
        ),
      ],
      child: const MyProviderApp(),
    ),
  );
}


class MyProviderApp extends StatelessWidget {
  const MyProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo - Provider',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PostProviderPage(),
    );
  }
}*/

//=====================================================
   //ALTERNATIVE (No DI) - Full standalone main (Provider, commented)

   // Copy this entire block and uncomment to run the app without GetIt/DI.

   import 'package:flutter/material.dart';
   import 'package:provider/provider.dart';
   import 'features/post/data/datasource/post_remote_datasource.dart';
   import 'features/post/data/repository/post_repository_impl.dart';
   import 'features/post/domain/usecases/get_usecase.dart';
   import 'features/post/presentaion/provider/post_provider.dart';
   import 'features/post/presentaion/pages/post/post_provider_page.dart';

   void main() {
     WidgetsFlutterBinding.ensureInitialized();

     // 1) Create concrete instances (no central DI)
     final postRemote = PostRemoteDataSourceImpl();
     final postRepo = PostRepositoryImpl(postRemote);
     final getPosts = GetPosts(postRepo);
     final getPostDetail = GetPostDetail(postRepo);

     // 2) Compose the provider in the widget tree using the concrete instances
     runApp(
       MultiProvider(
         providers: [
           ChangeNotifierProvider<PostProvider>(
             create: (_) => PostProvider(getPosts.call1, detailFetcher: getPostDetail.call2),
           ),
         ],
         child: const MyProviderAppNoDi(),
       ),
     );
   }

   /// A full MyApp variant to run without DI. It intentionally uses the same
   /// UI (`PostProviderPage`) so you can swap mains quickly.
   class MyProviderAppNoDi extends StatelessWidget {
     const MyProviderAppNoDi({super.key});

     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         title: 'Demo - Provider (No DI)',
         theme: ThemeData(
           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
         ),
         home: const PostProviderPage(),
       );
     }
   }

   //Notes:
   //- This block is entirely self-contained: imports, main, and MyApp class.
   //- To run without DI: replace the real `main()` in this file with the
   //  above `main()` (or copy this file and uncomment the block).
   //- After testing, revert to the DI-based `main` for scalable apps.
   //===================================================== 
   
