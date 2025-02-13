import 'package:flutter/material.dart';

class ShowLoader extends StatelessWidget {
  const ShowLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
