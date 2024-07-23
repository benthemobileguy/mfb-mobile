import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class TravelScreen extends StatefulWidget {
  const TravelScreen({super.key});

  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(
                context,
                "Travel",
              ),
              const Spacer(),
              Center(child: getCustomFont("No design for this yet", 16, h6, 1)),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
