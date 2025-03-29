import 'package:flutter_ecommerce/core/blocs/user_local_data/user_local_data_bloc.dart';
import 'package:flutter_ecommerce/core/repositories/image_uploader_repository.dart';
import 'package:flutter_ecommerce/core/repositories/user_local_data_repository.dart';
import 'package:flutter_ecommerce/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce/features/auth/repositories/auth_repository.dart';
import 'package:flutter_ecommerce/features/cart/blocs/bloc/cart_bloc.dart';
import 'package:flutter_ecommerce/features/cart/repositories/cart_repository.dart';
import 'package:flutter_ecommerce/features/category/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_ecommerce/features/category/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:flutter_ecommerce/features/category/repositories/category_repository.dart';
import 'package:flutter_ecommerce/features/product/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:flutter_ecommerce/features/product/blocs/product_bloc/product_bloc.dart';
import 'package:flutter_ecommerce/features/product/repositories/product_repository.dart';
import 'package:flutter_ecommerce/features/user/blocs/user_bloc/user_bloc.dart';
import 'package:flutter_ecommerce/features/user/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton(() => AuthBloc(repo: sl()));
  sl.registerLazySingleton(() => UserBloc(userRepo: sl()));
  sl.registerLazySingleton(() => UserLocalDataBloc(repo: sl()));
  sl.registerLazySingleton(() => CategoryBloc(repo: sl()));
  sl.registerLazySingleton(() => GetCategoryBloc(repo: sl()));
  sl.registerLazySingleton(() => ProductBloc(repo: sl()));
  sl.registerLazySingleton(() => GetProductBloc(repo: sl()));
  sl.registerLazySingleton(() => CartBloc(repo: sl()));

  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryI(
        client: sl(),
        imageUploaderRepo: sl(),
      ));

  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryI(
        client: sl(),
        imageUploaderRepo: sl(),
      ));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryI(client: sl(), repo: sl()));

  sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryI(client: sl(), userRepo: sl()));

  sl.registerLazySingleton<UserLocalDataRepository>(
      () => UserLocalDataRepositoryI(pref: sl()));

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryI(repo: sl(), client: sl()));

  sl.registerLazySingleton<ImageUploaderRepository>(
      () => ImageUploaderRepositoryI(client: sl()));

  SharedPreferences pref = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => pref);
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
}
