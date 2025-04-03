import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/utils/dialog_page.dart';
import 'package:flutter_ecommerce/common/utils/extension.dart';
import 'package:flutter_ecommerce/common/widgets/layout_scaffold.dart';
import 'package:flutter_ecommerce/core/repositories/user_local_data_repository.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/address/pages/address_form_page.dart';
import 'package:flutter_ecommerce/features/address/pages/address_page.dart';
import 'package:flutter_ecommerce/features/admin/pages/category_form_page.dart';
import 'package:flutter_ecommerce/features/admin/pages/product_form.dart';
import 'package:flutter_ecommerce/features/auth/pages/sign_in.dart';
import 'package:flutter_ecommerce/features/auth/pages/sign_up.dart';
import 'package:flutter_ecommerce/features/cart/pages/cart_page.dart';
import 'package:flutter_ecommerce/features/home/pages/home_page.dart';
import 'package:flutter_ecommerce/features/order/models/order_model.dart';
import 'package:flutter_ecommerce/features/order/pages/checkout_page.dart';
import 'package:flutter_ecommerce/features/order/pages/order_page.dart';
import 'package:flutter_ecommerce/features/order/pages/order_success_page.dart';
import 'package:flutter_ecommerce/features/product/models/product.dart';
import 'package:flutter_ecommerce/features/product/pages/product_detail_page.dart';
import 'package:flutter_ecommerce/features/user/pages/user_account.dart';
import 'package:go_router/go_router.dart';

class AppRouteName {
  static const String signUp = "sign-up";
  static const String signIn = "sign-in";
  static const String home = "home";
  static const String userProfile = "u";
  static const String search = "search";
  static const String cart = "cart";
  static const String checkout = "checkout";
  static const String categoryForm = "category-form";
  static const String productForm = "product-form";
  static const String addressForm = "address-form";
  static const String productDetailPage = "product";
  static const String orderSuccessPage = "order-confirm";
  static const String order = "orders";
  static const String address = "addresses";
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
      GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: AppRouteName.checkout.path,
          name: AppRouteName.checkout,
          builder: (context, state) {
            final BuyNowOrderModel? order = state.extra as BuyNowOrderModel?;
            return CheckOutPage(order: order);
          },
          routes: [
            GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              path: AppRouteName.orderSuccessPage.path,
              name: AppRouteName.orderSuccessPage,
              builder: (context, state) {
                final orderId = state.extra as String;
                return OrderSuccessPage(orderId: orderId);
              },
            ),
          ]),
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
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: "${AppRouteName.productDetailPage.path}/:id",
                      name: AppRouteName.productDetailPage,
                      builder: (context, state) {
                        final product = state.extra as Product?;

                        return ProductDetailPage(product: product);
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
                builder: (context, state) => const CartPage(),
              )
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
                      path: AppRouteName.address.path,
                      name: AppRouteName.address,
                      builder: (context, state) {
                        final bool? isSelectableAddresss = state.extra as bool?;
                        return AddressPage(
                          isSelectableAddress: isSelectableAddresss,
                        );
                      },
                    ),
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: AppRouteName.categoryForm.path,
                      name: AppRouteName.categoryForm,
                      builder: (context, state) => const CategoryFormPage(),
                    ),
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: AppRouteName.productForm.path,
                      name: AppRouteName.productForm,
                      builder: (context, state) => const ProductFormPage(),
                    ),
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: AppRouteName.addressForm.path,
                      name: AppRouteName.addressForm,
                      builder: (context, state) => const AddressFormPage(),
                    ),
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: AppRouteName.order.path,
                      name: AppRouteName.order,
                      builder: (context, state) {
                        return OrderPage();
                      },
                    ),
                  ]),
            ],
          ),
        ],
      ),
    ],
  );

  static Future<String?> _redirect(
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
