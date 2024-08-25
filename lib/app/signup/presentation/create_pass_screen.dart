import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../theme/color_data.dart';
import '../../routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  void finishView() {
    Constant.closeApp();
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var isPass = false;
  var isConfirmPass = false;

  @override
  Widget build(BuildContext context) {
    // FetchPixels(context);
    return WillPopScope(
      onWillPop: () async {
        finishView();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      backButtonWidget("back.svg", context: context),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      getCustomFont("Create New Password", 22, h6, 1,
                          fontWeight: FontWeight.w600),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      getDefaultTextFiledWithLabel(
                          context,
                          "Enter Password",
                          title: "Password",
                          passwordController,
                          textInputType: TextInputType.visiblePassword,
                          height: FetchPixels.getPixelHeight(60),
                          withSuffix: true,
                          suffixImage: "eye.svg",
                          isEnable: false,
                          isPass: isPass, imageFunction: () {
                        setState(() {
                          isPass = !isPass;
                        });
                      }),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      getDefaultTextFiledWithLabel(
                          context,
                          "Enter Password",
                          title: "Confirm Password",
                          confirmPasswordController,
                          textInputType: TextInputType.visiblePassword,
                          height: FetchPixels.getPixelHeight(60),
                          withSuffix: true,
                          suffixImage: "eye.svg",
                          isEnable: false,
                          isPass: isConfirmPass, imageFunction: () {
                        setState(() {
                          isConfirmPass = !isConfirmPass;
                        });
                      }),
                      getVerSpace(FetchPixels.getPixelHeight(19)),
                      getVerSpace(FetchPixels.getPixelHeight(
                          100)), // Added space to ensure the content is scrollable and doesn't overlap the bottom elements
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getButton(
                          context, primaryColor, "Create Account", Colors.white,
                          () {
                        Constant.sendToNext(context, Routes.verifyEmailRoute);
                      }, 16,
                          weight: FontWeight.w600,
                          borderRadius: BorderRadius.circular(
                              FetchPixels.getPixelHeight(15)),
                          buttonHeight: FetchPixels.getPixelHeight(60)),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'By creating an account, you agree to Tampay’s ',
                            style: TextStyle(
                              color: grey400Color,
                              fontSize: 14,
                              height: 1.7,
                              fontWeight: FontWeight.w500,
                              fontFamily: Constant.fontsFamily,
                            ),
                            children: [
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: success2Color,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Constant.fontsFamily,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    const url = 'https://example.com/privacy';
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(Uri.parse(url));
                                    }
                                  },
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(
                                  color: success2Color,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Constant.fontsFamily,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    const url = 'https://example.com/terms';
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(Uri.parse(url));
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
