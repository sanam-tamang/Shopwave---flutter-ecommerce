import 'package:flutter_ecommerce/common/blocs/user_local_data/user_local_data_bloc.dart';
import 'package:flutter_ecommerce/common/repositories/user_local_data_repository.dart';
import 'package:flutter_ecommerce/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce/features/auth/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton(() => AuthBloc(repo: sl()));
  sl.registerLazySingleton(() => UserLocalDataBloc(repo: sl()));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryI(client: sl(), repo: sl()));

  sl.registerLazySingleton<UserLocalDataRepository>(
      () => UserLocalDataRepositoryI(pref: sl()));

  SharedPreferences pref = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => pref);
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
}
