import 'package:blogclean/core/common/show_snackbar.dart/snackbar.dart';
import 'package:blogclean/core/theme/app_palete.dart';
import 'package:blogclean/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogclean/feature/auth/presentation/pages/login_page.dart';
import 'package:blogclean/feature/auth/presentation/widgets/auth_field.dart';
import 'package:blogclean/feature/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/custom_loading_indicator.dart';

class SignupPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SignupPage(),
    );
  }

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetFields() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16,
          top: MediaQuery.of(context).size.height * 0.2,
        ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              resetFields();
              showSnackBar(
                context: context,
                content: state.message,
              );
            }
            if (state is AuthSuccess) {
              showSnackBar(context: context, content: 'Sign up success');
              Navigator.of(context).push(LoginPage.route());
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return ShowLoader();
            }

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16.0,
                      ),
                      child: AuthField(
                        controller: _nameController,
                        hintText: 'Name',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16.0,
                      ),
                      child: AuthField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: AuthField(
                        controller: _passwordController,
                        hintText: 'Password',
                        isObScure:
                            state is ShowPassword ? state.showPassword : false,
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            ShowPasswordEvent(
                              state is ShowPassword
                                  ? !state.showPassword
                                  : true,
                            ),
                          );
                        },
                      ),
                    ),
                    AuthGradientButton(
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthSignUpEvent(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                      text: 'Sign up',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(LoginPage.route());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account?",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: " Sign In",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppPallete.gradient2,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
