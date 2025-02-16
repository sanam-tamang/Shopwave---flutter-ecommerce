import 'package:flutter_ecommerce/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce/features/auth/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt sl = GetIt.instance;
void init() {
  sl.registerLazySingleton(() => AuthBloc(repo: sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryI(client: sl()));

  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
}
