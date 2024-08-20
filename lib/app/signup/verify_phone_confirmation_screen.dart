import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/app/view/dialog/verify_dialog.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class VerifyPhoneConfirmationScreen extends StatefulWidget {
  const VerifyPhoneConfirmationScreen({super.key});

  @override
  State<VerifyPhoneConfirmationScreen> createState() =>
      _VerifyPhoneConfirmationScreenState();
}

class _VerifyPhoneConfirmationScreenState
    extends State<VerifyPhoneConfirmationScreen> {
  void finishView() {
    Constant.closeApp();
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
    return Scaffold(
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
                      'We’ve sent you an OTP Code via SMS. Please enter 6-digit code sent to  ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    height: 1.7,
                    fontWeight: FontWeight.w500,
                    fontFamily: Constant.fontsFamily,
                  ),
                  children: [
                    TextSpan(
                      text: '08100345678',
                      style: TextStyle(
                        color: success2Color,
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: Constant.fontsFamily,
                      ),
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
                    showToast(context, "Phone number verified");
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
                              description: "Code has been resent successfully!",
                              okText: "Ok",
                              onOk: () {
                                Navigator.pop(context);
                              });
                        },
                        context: context);
                  },
                  child:
                      getCustomFont("Resend code in 50 secs", 12, grey700, 1))
            ],
          ),
        ),
      ),
    );
  }
}
