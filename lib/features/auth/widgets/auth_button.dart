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
          listener: (context, state) => state.maybeWhen(
              loaded: (data) {
                AppToast.success(context, data);
                context.goNamed(AppRouteName.home);
                return null;
              },
              failure: (failure) => AppToast.error(context, failure.toString()),
              orElse: () {
                return null;
              }),
          builder: (context, state) {
            return state.maybeWhen(
                loading: () => Center(child: CircularProgressIndicator()),
                orElse: () => FilledButton(
                    onPressed: onPressed, child: Text(buttonText)));
          },
        ));
  }
}
