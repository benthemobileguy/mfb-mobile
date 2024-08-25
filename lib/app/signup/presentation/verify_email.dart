import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../theme/color_data.dart';
import '../../routes/app_routes.dart';
import '../../view/dialog/verify_dialog.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  void finishView() {
    Constant.backToPrev(context);
  }

  FocusNode myFocusNode = FocusNode();
  Color color = borderColor;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: FetchPixels.getPixelHeight(60),
      height: FetchPixels.getPixelHeight(
        60,
      ),
      textStyle: TextStyle(
        fontSize: FetchPixels.getPixelHeight(24),
        color: grey900Color,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border.all(color: color, width: FetchPixels.getPixelHeight(1)),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
    );
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
                  getCustomFont("Verify Email", 22, h6, 1,
                      fontWeight: FontWeight.w600),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text:
                          'We’ve sent you an OTP Code via Email. Please enter 6-digit code sent to ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        height: 1.7,
                        fontWeight: FontWeight.w500,
                        fontFamily: Constant.fontsFamily,
                      ),
                      children: [
                        TextSpan(
                          text: 'jeffmamudu@gmail.com',
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
                      ],
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(25)),
                  getMultilineCustomFont("Enter Code", 13, Colors.black,
                      fontWeight: FontWeight.w400,
                      txtHeight: FetchPixels.getPixelHeight(1.3),
                      textAlign: TextAlign.center),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        setState(() {
                          color = greyColor300;
                          myFocusNode.canRequestFocus = true;
                        });
                      } else {
                        setState(() {
                          color = borderColor;
                          myFocusNode.canRequestFocus = false;
                        });
                      }
                    },
                    child: Pinput(
                      defaultPinTheme: defaultPinTheme,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      cursor: Container(),
                      length: 6,
                      focusNode: myFocusNode,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) {
                        showDialog(
                            barrierDismissible: true,
                            builder: (context) {
                              return VerifyDialog(
                                title: "Account Creation",
                                description:
                                    "Your account has been successfully created!",
                                onOk: () {
                                  Constant.sendToNext(
                                      context, Routes.welcomeRoute);
                                },
                                okText: "Ok",
                              );
                            },
                            context: context);
                      },
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(25)),
                  InkWell(
                      onTap: () {
                        showDialog(
                            barrierDismissible: true,
                            builder: (context) {
                              return VerifyDialog(
                                  title: "Check Inbox",
                                  description:
                                      "Code has been resent successfully!",
                                  okText: "Ok",
                                  onOk: () {
                                    Navigator.pop(context);
                                  });
                            },
                            context: context);
                      },
                      child: getCustomFont(
                          "Resend code in 50 secs", 12, grey700, 1))
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }
}
