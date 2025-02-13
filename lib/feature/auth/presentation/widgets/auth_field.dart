import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool isObScure;
  final VoidCallback? onTap;
  final TextEditingController controller;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObScure = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObScure,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hintText';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: onTap != null
              ? IconButton(
                  onPressed: onTap,
                  icon:
                      Icon(isObScure ? Icons.visibility : Icons.visibility_off))
              : null),
    );
  }
}
