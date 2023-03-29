import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping/app/app.dart';
import 'package:ping/app/router/paths.dart';
import 'package:ping/app/router/router.dart';
import 'package:ping/theme.dart';
import 'package:ping_repos/ping_repos.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _userAuthListener();
  }

  _userAuthListener() {
    AuthenticationRepository.user.listen((user) {
      if (user == null) {
        AppRouter.router.go(AppPaths.login);
      } else {
        AppRouter.router.go(AppPaths.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          title: 'PiNG',
          debugShowCheckedModeBanner: false,
          theme: theme,
        ),
      ),
    );
  }
}
