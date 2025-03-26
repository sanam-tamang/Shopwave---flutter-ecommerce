import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/utils/extension.dart';
import 'package:flutter_ecommerce/common/widgets/layout_scaffold.dart';
import 'package:flutter_ecommerce/core/repositories/user_local_data_repository.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/admin/pages/category_form_page.dart';
import 'package:flutter_ecommerce/features/auth/pages/sign_in.dart';
import 'package:flutter_ecommerce/features/auth/pages/sign_up.dart';
import 'package:flutter_ecommerce/features/home/pages/home_page.dart';
import 'package:flutter_ecommerce/features/user/pages/user_account.dart';
import 'package:go_router/go_router.dart';

class AppRouteName {
  static const String signUp = "sign-up";
  static const String signIn = "sign-in";
  static const String home = "home";
  static const String userProfile = "u";
  static const String search = "search";
  static const String cart = "cart";
  static const String categoryForm = "category-form";
  static const String authGuard = "grd";
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> homeNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> searchNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> cartNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> accountNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellKey = GlobalKey<NavigatorState>();

class AppRoute {
  static GoRouter route = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: "/",
    routes: [
      GoRoute(
        path: AppRouteName.signUp.path,
        name: AppRouteName.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: AppRouteName.signIn.path,
        name: AppRouteName.signIn,
        builder: (context, state) => const SignInPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return LayoutScaffold(shell: navigationShell);
        },
        redirect: _redirect,
        branches: [
          StatefulShellBranch(
            navigatorKey: homeNavKey,
            routes: [
              GoRoute(
                  path: AppRouteName.home.rootPath,
                  name: AppRouteName.home,
                  builder: (context, state) => const HomePage(),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: AppRouteName.authGuard,
                      name: AppRouteName.authGuard,
                      pageBuilder: (context, state) {
                        return DialogPage(builder: (context) => SignInPage());
                      },
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: searchNavKey,
            routes: [
              GoRoute(
                path: AppRouteName.search.path,
                name: AppRouteName.search,
                builder: (context, state) => const UserAccountPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: cartNavKey,
            routes: [
              GoRoute(
                path: AppRouteName.cart.path,
                name: AppRouteName.cart,
                builder: (context, state) => const UserAccountPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: accountNavKey,
            routes: [
              GoRoute(
                  path: AppRouteName.userProfile.path,
                  name: AppRouteName.userProfile,
                  builder: (context, state) => const UserAccountPage(),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: AppRouteName.categoryForm.path,
                      name: AppRouteName.categoryForm,
                      builder: (context, state) => const CategoryFormPage(),
                    ),
                  ]),
            ],
          ),
        ],
      ),
    ],
  );

  static FutureOr<String?> _redirect(
      BuildContext context, GoRouterState state) async {
    final currentPath = state.uri.path;
    debugPrint("**********");
    debugPrint(currentPath);
    final isAuthPath = currentPath == AppRouteName.signIn.path ||
        currentPath == AppRouteName.signUp.path;

    final isAuthGuardingPath = currentPath == AppRouteName.userProfile.path ||
        currentPath == AppRouteName.cart.path;

    // await sl<UserLocalDataRepository>().deleteData();
    final failureOrUser = await sl<UserLocalDataRepository>().getData();
    final currentUser = failureOrUser.fold((failure) => null, (user) => user);

    if (isAuthGuardingPath && currentUser == null) {
      return AppRouteName.authGuard.path;
    }

    if (isAuthPath && currentUser != null) {
      return AppRouteName.home.rootPath;
    }

    return null; // Allow access
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
    this.barrierColor = Colors.black38,
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
