import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class ConversionSuccessScreen extends StatefulWidget {
  const ConversionSuccessScreen({super.key});

  @override
  State<ConversionSuccessScreen> createState() =>
      _ConversionSuccessScreenState();
}

class _ConversionSuccessScreenState extends State<ConversionSuccessScreen> {
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
            getCustomFont("Dollar Account Credited With", 16.5, blue, 1,
                fontWeight: FontWeight.normal),
            getVerSpace(20),
            getCustomFont("\$114.54", 36, Colors.black, 1,
                fontWeight: FontWeight.normal),
            getVerSpace(20),
            InkWell(
              onTap: () {
                Constant.sendToNext(context, Routes.homeScreenRoute);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
