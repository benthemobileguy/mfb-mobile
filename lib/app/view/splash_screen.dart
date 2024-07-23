import 'dart:async';
import 'package:flutter/material.dart';
import '../../base/constant.dart';
import '../../base/pref_data.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../../theme/color_data.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getStarting();
  }

  getStarting() async {
    bool isLogin = await PrefData.isLogIn();
    bool isIntro = await PrefData.getIntro();
    Timer(const Duration(seconds: 5), () {
      if (isIntro) {
        Constant.sendToNext(context, Routes.introRoute);
      } else if (isLogin) {
        Constant.sendToNext(context, Routes.loginRoute);
      } else {
        Constant.sendToNext(context, Routes.homeScreenRoute);
      }
    });
  }

  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      body: Stack(
        children: [
          getPngImage(
            boxFit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            "splash_bg.png",
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                getPngImage("welcome_tampay.png", width: 185, height: 139),
                getVerSpace(FetchPixels.getPixelHeight(50)),
                viewDashboardButton(context),
                getVerSpace(FetchPixels.getPixelHeight(30)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget viewDashboardButton(BuildContext context) {
    return getButton(context, Colors.transparent, "View Dashboard", grey700,
        () {
      Constant.sendToNext(context, Routes.introRoute);
    }, 16,
        weight: FontWeight.w600,
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(16)),
        buttonHeight: FetchPixels.getPixelHeight(60),
        isBorder: true,
        borderColor: grey700,
        borderWidth: FetchPixels.getPixelHeight(2));
  }
}
