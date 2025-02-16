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

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
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
                        "Sign up",
                        style: TextTheme.of(context).titleMedium,
                      ),
                      Gap(24),
                      SizedBox(
                          width: 30,
                          height: 30,
                          child:
                              SvgPicture.asset('assets/icons/google-icon.svg')),
                      Gap(18),
                      Text("Or use email to Sign up"),
                    ],
                  ),
                ),
                Spacer(),
                Text("Name"),
                Gap(4),
                AppTextField(
                  controller: _nameController,
                  hintText: "Enter your name",
                  validator: Validators.validateName,
                ),
                Gap(18),
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
                Spacer(flex: 3),
                AuthButton(
                  buttonText: "Sign Up",
                  onPressed: _onSignUp,
                ),
                Gap(16),
                SizedBox(
                    width: double.maxFinite,
                    child: OutlinedButton(
                        onPressed: () => context.goNamed(AppRouteName.signIn),
                        child: Text("Sign In"))),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSignUp() {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;

      sl<AuthBloc>()
          .add(AuthEvent.signUp(name: name, email: email, password: password));
    }
  }
}
