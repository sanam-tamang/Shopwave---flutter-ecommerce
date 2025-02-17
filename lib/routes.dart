import 'package:flutter_ecommerce/common/extension.dart';
import 'package:flutter_ecommerce/common/repositories/user_local_data_repository.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/auth/pages/sign_in.dart';
import 'package:flutter_ecommerce/features/auth/pages/sign_up.dart';
import 'package:flutter_ecommerce/features/navbar/navbar.dart';
import 'package:go_router/go_router.dart';

class AppRouteName {
  static const String signUp = "sign-up";
  static const String signIn = "sign-in";
  static const String navbar = "navbar";
}

class AppRoute {
  static GoRouter route = GoRouter(
      redirect: (context, state) async {
        final currentPath = state.uri.path;
        final isAuthPath = currentPath == AppRouteName.signIn.path ||
            currentPath == AppRouteName.signUp.path;

        if (isAuthPath) {
          final failureOrUser = await sl<UserLocalDataRepository>().getData();

          return failureOrUser.fold(
              (failure) => null, (user) => AppRouteName.navbar.rootPath);
        }

        return null;
      },
      initialLocation: AppRouteName.signIn.path,
      routes: [
        GoRoute(
          path: AppRouteName.signUp.path,
          name: AppRouteName.signUp,
          builder: (context, state) => SignUpPage(),
        ),
        GoRoute(
          path: AppRouteName.signIn.path,
          name: AppRouteName.signIn,
          builder: (context, state) => SignInPage(),
        ),
        GoRoute(
          path: AppRouteName.navbar.rootPath,
          name: AppRouteName.navbar,
          builder: (context, state) => NavBarPage(),
        ),
      ]);
}
