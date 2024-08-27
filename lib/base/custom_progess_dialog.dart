import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomProgressDialog extends StatelessWidget {
  const CustomProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Lottie.asset('assets/lottie/loader.json'),
      ),
    );
  }
}
