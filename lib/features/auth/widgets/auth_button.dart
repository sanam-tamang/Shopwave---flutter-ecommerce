// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecommerce/common/utils/toast_msg.dart';
import 'package:flutter_ecommerce/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:go_router/go_router.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) => state.whenOrNull(
              loaded: (data) {
                AppToast.success(context, data);
                return context.goNamed(AppRouteName.navbar);
              },
              failure: (failure) =>
                  AppToast.error(context, failure.toString())),
          builder: (context, state) {
            return FilledButton(
                onPressed: onPressed,
                child: state.maybeWhen(
                    loading: () => CircularProgressIndicator(),
                    orElse: () => Text(buttonText)));
          },
        ));
  }
}
