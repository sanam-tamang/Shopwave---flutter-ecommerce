import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/core/repositories/user_local_data_repository.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:go_router/go_router.dart';

Future<void> authCheckFunction(
    BuildContext context, void Function() successCallback) async {
  final repo = sl<UserLocalDataRepository>();
  final failureOrData = await repo.getData();
  failureOrData.fold((failure) {
    context.pushNamed(AppRouteName.authGuard);
  }, (success) {
    successCallback();
  });
}
