import 'package:flutter/material.dart';
import 'package:tampay_mobile/base/widget_utils.dart';

import '../../../../../../theme/color_data.dart';

class InsuranceScreen extends StatefulWidget {
  const InsuranceScreen({super.key});

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
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
                "Insurance",
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
