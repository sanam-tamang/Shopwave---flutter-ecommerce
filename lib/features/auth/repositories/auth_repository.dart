import 'dart:math';

import 'package:flutter_ecommerce/common/model/local_user_model.dart';
import 'package:flutter_ecommerce/common/repositories/user_local_data_repository.dart';
import 'package:flutter_ecommerce/core/excetion.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_ecommerce/common/typedef.dart';

abstract interface class AuthRepository {
  FutureEither<String> signUp(
      {required String name, required String password, required String email});

  FutureEither<String> signIn(
      {required String password, required String email});

  FutureEither<String> signOut();
}

class AuthRepositoryI implements AuthRepository {
  final SupabaseClient _client;
  final UserLocalDataRepository _repo;
  AuthRepositoryI(
      {required SupabaseClient client, required UserLocalDataRepository repo})
      : _repo = repo,
        _client = client;

  @override
  FutureEither<String> signUp(
      {required String name,
      required String password,
      required String email}) async {
    return await handleApplicationException(() async {
      final response = await _client.auth
          .signUp(email: email, password: password, data: {'name': name});
      await _client.from('users').insert({
        'id': response.user!.id,
        'name': name,
        'email': email,
        'username':
            "dispaly${Random().nextInt(99)}${Random().nextInt(100)}${Random().nextInt(90000)}"
      });
      await _repo.writeData(
          LocalUserModel(userId: response.user!.id, role: "general"));
      return "User registered successfully";
    });
  }

  @override
  FutureEither<String> signIn(
      {required String password, required String email}) async {
    return await handleApplicationException(() async {
      await _client.auth.signInWithPassword(email: email, password: password);
      return "User logged in successfully";
    });
  }

  @override
  FutureEither<String> signOut() async {
    return await handleApplicationException(() async {
      await _client.auth.signOut();
      return "User logged out successfully";
    });
  }
}
