import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce/common/model/local_user_model.dart';
import 'package:flutter_ecommerce/common/typedef.dart';
import 'package:flutter_ecommerce/core/failure/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class UserLocalDataRepository {
  FutureEither<LocalUserModel> getData();
  FutureEither<void> writeData(LocalUserModel user);
  FutureEither<void> deleteData();
}

class UserLocalDataRepositoryI implements UserLocalDataRepository {
  final SharedPreferences _pref;
  static const String _userKey = 'local_user_data';

  UserLocalDataRepositoryI({required SharedPreferences pref}) : _pref = pref;

  @override
  FutureEither<LocalUserModel> getData() async {
    try {
      final String? userData = _pref.getString(_userKey);
      if (userData == null) {
        return Left(FailureWithMsg('No user data found'));
      }
      final Map<String, dynamic> jsonMap = json.decode(userData);
      return Right(LocalUserModel.fromJson(jsonMap));
    } catch (e) {
      return Left(FailureWithMsg('Failed to retrieve user data: $e'));
    }
  }

  @override
  FutureEither<void> writeData(LocalUserModel user) async {
    try {
      final String jsonString = json.encode(user.toJson());
      final success = await _pref.setString(_userKey, jsonString);
      if (!success) throw FailureWithMsg('Failed to save user data');
      return const Right(null);
    } catch (e) {
      return Left(FailureWithMsg('Failed to save user data: $e'));
    }
  }

  @override
  FutureEither<void> deleteData() async {
    try {
      final success = await _pref.remove(_userKey);
      if (!success) throw FailureWithMsg('Failed to delete user data');
      return const Right(null);
    } catch (e) {
      return Left(FailureWithMsg('Failed to delete user data: $e'));
    }
  }
}
