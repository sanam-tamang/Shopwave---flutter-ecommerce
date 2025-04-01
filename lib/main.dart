import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ecommerce/common/theme/app_theme.dart';
import 'package:flutter_ecommerce/core/blocs/user_local_data/user_local_data_bloc.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce/features/cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce/features/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:flutter_ecommerce/features/category/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_ecommerce/features/category/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:flutter_ecommerce/features/product/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:flutter_ecommerce/features/product/blocs/product_bloc/product_bloc.dart';
import 'package:flutter_ecommerce/features/user/blocs/user_bloc/user_bloc.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final url = dotenv.get('SUPABASE_URL');
  final annonKey = dotenv.get('SUPABASE_ANNONKEY');
  await Supabase.initialize(
    url: url,
    anonKey: annonKey,
  );

  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<CategoryBloc>()),
        BlocProvider(create: (context) => sl<ProductBloc>()),
        BlocProvider(create: (context) => sl<CartBloc>()),
        BlocProvider(
            create: (context) => sl<GetCartBloc>()..add(GetCartEvent.get())),
        BlocProvider(
            create: (context) =>
                sl<GetProductBloc>()..add(GetProductEvent.get())),
        BlocProvider(
            create: (context) =>
                sl<GetCategoryBloc>()..add(GetCategoryEvent.get())),
        BlocProvider(
            create: (context) =>
                sl<UserLocalDataBloc>()..add(UserLocalDataEvent.get())),
        BlocProvider(
            create: (context) =>
                sl<UserBloc>()..add(UserEvent.getCurrentUserData())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Flutter Ecommerce",
        routerConfig: AppRoute.route,
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
      ),
    );
  }
}
