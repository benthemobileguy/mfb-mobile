import 'package:flutter/material.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

import '../../../../../base/constant.dart';
import '../../../../routes/app_routes.dart';

class TransactionSuccessfulScreen extends StatefulWidget {
  const TransactionSuccessfulScreen({super.key});

  @override
  State<TransactionSuccessfulScreen> createState() =>
      _TransactionSuccessfulScreenState();
}

class _TransactionSuccessfulScreenState
    extends State<TransactionSuccessfulScreen> {
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
            getCustomFont("Transaction Successful", 16, grey700, 1,
                fontWeight: FontWeight.w600),
            getVerSpace(20),
            getCustomFont(
                "45,000 is on it’s way to  Mamudu Jeffrey", 14.5, grey700, 1,
                fontWeight: FontWeight.normal),
            getVerSpace(20),
            InkWell(
              onTap: () {
                Constant.sendToNext(context, Routes.transactionDetailsRoute);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: getCustomFont(
                    "Share Transaction Details", 14.5, Colors.white, 1,
                    fontWeight: FontWeight.normal),
              ),
            ),
            getVerSpace(10),
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
