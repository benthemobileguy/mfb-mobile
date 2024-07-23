import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class FundingSuccessScreen extends StatefulWidget {
  const FundingSuccessScreen({super.key});

  @override
  State<FundingSuccessScreen> createState() => _FundingSuccessScreenState();
}

class _FundingSuccessScreenState extends State<FundingSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: getSvgImage("check.svg")),
            getVerSpace(20),
            getCustomFont("Account Funded Successfully", 16, grey700, 1,
                fontWeight: FontWeight.w600),
            getVerSpace(20),
            InkWell(
              onTap: () {
                Constant.sendToNext(context, Routes.homeScreenRoute);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: getCustomFont("View Balance", 14.5, Colors.white, 1,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
