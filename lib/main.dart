import 'package:advanced_todo_app/features/authentication/app/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/resources/colours.dart';
import 'features/on_boarding/views/on_boarding_screen.dart';
import 'features/todo/views/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    debugPrint(screenSize.toString());

    return ScreenUtilInit(
        designSize: const Size(392.7, 805.1),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Advanced Todo App',
            theme: ThemeData(
              scaffoldBackgroundColor: AppColours.kBackgroundBlack,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
              useMaterial3: true,
            ),
            home: ref.watch(userProvider).when(
                  data: (userExists)
                  {
                    if(userExists) return const HomeScreen();
                    return const OnBoardingScreen();
                  },
                  error: (error, stackTrace) {
                    debugPrint('ERROR: $error');
                    debugPrint(stackTrace.toString());
                    return const OnBoardingScreen();
                  },
                  loading: () {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
          );
        });
  }
}
