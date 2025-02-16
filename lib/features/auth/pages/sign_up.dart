import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/app_text_field.dart';
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
      body: Padding(
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
                            SvgPicture.asset('assets/images/google-icon.svg')),
                    Gap(18),
                    Text("Or use email to Sign up"),
                  ],
                ),
              ),
              Spacer(),
              Text("Name"),
              Gap(4),
              AppTextField(
                  controller: _nameController, hintText: "Enter your name"),
              Gap(18),
              Text("Email"),
              Gap(4),
              AppTextField(
                  controller: _emailController, hintText: "Enter your email"),
              Gap(18),
              Text("Password"),
              Gap(4),
              AppTextField(
                  controller: _passwordController,
                  hintText: "Enter your password"),
              Spacer(flex: 3),
              SizedBox(
                  width: double.maxFinite,
                  child:
                      FilledButton(onPressed: () {}, child: Text("Sign Up"))),
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
    );
  }
}
