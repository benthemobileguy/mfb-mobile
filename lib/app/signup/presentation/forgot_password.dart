import 'package:flutter/material.dart';

import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../theme/color_data.dart';
import '../../routes/app_routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  void finish() {
    Constant.backToPrev(context);
  }

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backButtonWidget("back.svg", context: context),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getCustomFont("Forgot Password", 22, Colors.black, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  getMultilineCustomFont(
                      "Please enter the email attached to your account to reset your password",
                      12,
                      Colors.black,
                      fontWeight: FontWeight.w300,
                      txtHeight: FetchPixels.getPixelHeight(1.3),
                      textAlign: TextAlign.start),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  getDefaultTextFiledWithLabel(
                      context, "Email", emailController,
                      isEnable: false, height: FetchPixels.getPixelHeight(60)),
                  const Spacer(),
                  getButton(
                      context, primaryColor, "Reset Password", Colors.white,
                      () {
                    //  Constant.sendToNext(context, Routes.changePasswordRoute);
                    Navigator.pop(context);
                  }, 16,
                      weight: FontWeight.w600,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                      buttonHeight: FetchPixels.getPixelHeight(60)),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }
}
