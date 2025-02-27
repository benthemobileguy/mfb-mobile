import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/view/transactions/presentation/controller/transactions_controller.dart';
import '../../base/constant.dart';
import '../../base/pref_data.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../../theme/color_data.dart';
import '../profile/presentation/controller/profile_controller.dart';
import '../routes/app_routes.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getStarting();
  }

  getStarting() async {
    bool isLogin = await PrefData.isLoggedIn();
    bool isOnBoardingCompleted = await PrefData.getIsOnboardingCompleted();
    Timer(const Duration(seconds: 5), () async {
      if (isOnBoardingCompleted) {
        if (isLogin) {
          await ref
              .read(profileControllerProvider)
              .getProfile()
              .then((value) async {
            await ref
                .read(transactionsControllerProvider)
                .getRecentTransactions();
            await ref.read(transactionsControllerProvider).getBanks();
            Constant.sendToNext(context, Routes.homeScreenRoute);
          });
        } else {
          Constant.sendToNext(context, Routes.loginRoute);
        }
      } else {
        Constant.sendToNext(context, Routes.introRoute);
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
      body: Center(
        // add lottie file
        child: Lottie.asset(
          'assets/lottie/splash_logo.json',
          controller: _controller,
          repeat: false,
          onLoaded: (composition) {
            // Configure the AnimationController with the duration of the
            // Lottie file and start the animation.
            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
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
