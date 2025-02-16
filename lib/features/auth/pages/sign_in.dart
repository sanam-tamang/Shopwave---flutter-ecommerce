import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/utils/validator.dart';
import 'package:flutter_ecommerce/common/widgets/app_text_field.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce/features/auth/widgets/auth_button.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: DefaultTextStyle(
            style: TextTheme.of(context).labelLarge!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(8),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sign In",
                        style: TextTheme.of(context).titleMedium,
                      ),
                      Gap(24),
                      SizedBox(
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset(
                              'assets/images/google-icon.svg')),
                      Gap(18),
                      Text("Or use email to Sign In"),
                    ],
                  ),
                ),
                Spacer(),
                Text("Email"),
                Gap(4),
                AppTextField(
                  controller: _emailController,
                  hintText: "Enter your email",
                  validator: Validators.validateEmail,
                ),
                Gap(18),
                Text("Password"),
                Gap(4),
                AppTextField(
                  controller: _passwordController,
                  hintText: "Enter your password",
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                Gap(1),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: Text("Forget password"))),
                Spacer(flex: 3),
                AuthButton(
                  buttonText: "Sign In",
                  onPressed: _onSignIn,
                ),
                Gap(16),
                SizedBox(
                    width: double.maxFinite,
                    child: OutlinedButton(
                        onPressed: () => context.goNamed(AppRouteName.signUp),
                        child: Text("Sign Up"))),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSignIn() {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      sl<AuthBloc>().add(AuthEvent.signIn(email: email, password: password));
    }
  }
}
