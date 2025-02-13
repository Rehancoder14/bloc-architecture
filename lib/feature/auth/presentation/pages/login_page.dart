import 'package:blogclean/core/common/show_snackbar.dart/snackbar.dart';
import 'package:blogclean/core/common/widgets/custom_loading_indicator.dart';
import 'package:blogclean/core/theme/app_palete.dart';
import 'package:blogclean/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogclean/feature/auth/presentation/pages/signup_page.dart';
import 'package:blogclean/feature/auth/presentation/widgets/auth_field.dart';
import 'package:blogclean/feature/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const LoginPage(),
    );
  }

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoginError) {
              _resetFields();
              showSnackBar(
                context: context,
                content: state.message,
              );
            }
            if (state is AuthSuccess) {
              showSnackBar(context: context, content: 'Sign in success');
              // Navigator.of(context).push(LoginPage.route());
            }
          },
          builder: (context, state) {
            if (state is AuthLoginLoading) {
              return ShowLoader();
            }
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
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
                      isObScure: true,
                    ),
                  ),
                  AuthGradientButton(
                    text: 'Sign In',
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AuthBloc>().add(
                              AuthLoginEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(SignupPage.route()),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account?",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: " Sign up",
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
            );
          },
        ),
      ),
    );
  }

  void _resetFields() {
    _emailController.clear();
    _passwordController.clear();
  }
}
