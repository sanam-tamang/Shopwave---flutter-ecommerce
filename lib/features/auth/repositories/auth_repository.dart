import 'package:flutter_ecommerce/core/excetion.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_ecommerce/common/typedef.dart';

abstract interface class AuthRepository {
  FutureFailureOrData<String> signUp(
      {required String name, required String password, required String email});

  FutureFailureOrData<String> signIn(
      {required String password, required String email});

  FutureFailureOrData<String> signOut();
}

class AuthRepositoryI implements AuthRepository {
  final SupabaseClient _client;
  AuthRepositoryI({required SupabaseClient client}) : _client = client;

  @override
  FutureFailureOrData<String> signUp(
      {required String name,
      required String password,
      required String email}) async {
    return await handleApplicationException(() async {
      await _client.auth
          .signUp(email: email, password: password, data: {'name': name});
      return "User registered successfully";
    });
  }

  @override
  FutureFailureOrData<String> signIn(
      {required String password, required String email}) async {
    return await handleApplicationException(() async {
      await _client.auth.signInWithPassword(email: email, password: password);
      return "User logged in successfully";
    });
  }

  @override
  FutureFailureOrData<String> signOut() async {
    return await handleApplicationException(() async {
      await _client.auth.signOut();
      return "User logged out successfully";
    });
  }
}
