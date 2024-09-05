import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void finishView() {
    Constant.closeApp();
  }

  @override
  void initState() {
    super.initState();
    getStarting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          getPngImage(
            "welcome_bg.png",
          ),
          getVerSpace(30),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
              top: FetchPixels.getPixelHeight(20),
            ),
            child: getAssetImage("logo_dark.png", width: 60, height: 60),
          ),
          getVerSpace(20),
          getCustomFont("Welcome to\nTampay", 33, grey700, 3,
              textAlign: TextAlign.center, fontWeight: FontWeight.w600),
        ],
      ),
    );
  }

  void getStarting() {
    Timer(const Duration(seconds: 5), () {
      Constant.sendToNext(context, Routes.homeScreenRoute);
    });
  }
}
