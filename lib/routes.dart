import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/utils/extension.dart';
import 'package:flutter_ecommerce/common/widgets/layout_scaffold.dart';
import 'package:flutter_ecommerce/core/repositories/user_local_data_repository.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/auth/pages/sign_in.dart';
import 'package:flutter_ecommerce/features/auth/pages/sign_up.dart';
import 'package:flutter_ecommerce/features/home/pages/home_page.dart';
import 'package:flutter_ecommerce/features/user/pages/user_account.dart';
import 'package:go_router/go_router.dart';

class AppRouteName {
  static const String signUp = "sign-up";
  static const String signIn = "sign-in";
  static const String signInWithDialog = "sign-in-dialog";
  static const String home = "home";
  static const String userProfile = "u";
  static const String search = "search";
  static const String cart = "cart";
  static const String unAuthHome = "u-home";
}

class AppRoute {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> _homeKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _searchkey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _cartKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _userKey = GlobalKey<NavigatorState>();

  static GoRouter route = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: AppRouteName.home.path,
      // navigatorKey: _rootNavigatorKey,
      routes: [
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return LayoutScaffold(shell: navigationShell);
            },
            redirect: _redirect,
            branches: [
              StatefulShellBranch(navigatorKey: _homeKey, routes: [
                GoRoute(
                  path: AppRouteName.home.path,
                  name: AppRouteName.home,
                  builder: (context, state) => HomePage(),
                ),
              ]),
              StatefulShellBranch(navigatorKey: _searchkey, routes: [
                GoRoute(
                  path: AppRouteName.search.path,
                  name: AppRouteName.search,
                  builder: (context, state) => UserAccountPage(),
                ),
              ]),
              StatefulShellBranch(navigatorKey: _cartKey, routes: [
                GoRoute(
                  path: AppRouteName.cart.path,
                  name: AppRouteName.cart,
                  builder: (context, state) => UserAccountPage(),
                ),
              ]),
              StatefulShellBranch(navigatorKey: _userKey, routes: [
                GoRoute(
                  path: AppRouteName.userProfile.path,
                  name: AppRouteName.userProfile,
                  builder: (context, state) => UserAccountPage(),
                ),
              ]),
            ]),
        GoRoute(
          path: AppRouteName.signInWithDialog.path,
          name: AppRouteName.signInWithDialog,
          parentNavigatorKey:
              _rootNavigatorKey, // Use root navigator for dialogs
          pageBuilder: (context, state) =>
              DialogPage(builder: (context) => SignInPage()),
        ),
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
      ]);

  static FutureOr<String?> _redirect(context, state) async {
    final currentPath = state.uri.path;
    final isAuthPath = currentPath == AppRouteName.signIn.path ||
        currentPath == AppRouteName.signUp.path;

    final doesUserNeedToBeAuthenticatedBeforeAccesingCurrentPath =
        currentPath == AppRouteName.userProfile.path ||
            currentPath == AppRouteName.cart.path;

    final failureOrUser = await sl<UserLocalDataRepository>().getData();

    final currentUser = failureOrUser.fold((failure) => null, (user) => user);

    if (doesUserNeedToBeAuthenticatedBeforeAccesingCurrentPath &&
        currentUser == null) {
      return AppRouteName.signInWithDialog.path;
    }

    if (isAuthPath && currentUser != null) {
      return AppRouteName.home.path;
    }
    return null;
  }
}

class DialogPage<T> extends Page<T> {
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  const DialogPage({
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black87,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        builder: (context) => Dialog(
          child: builder(context),
        ),
        anchorPoint: anchorPoint,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        themes: themes,
      );
}
