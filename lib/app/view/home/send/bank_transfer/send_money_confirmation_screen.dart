import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import '../../../../../base/constant.dart';
import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../../theme/color_data.dart';
import '../../../../routes/app_routes.dart';

class SendMoneyConfirmationScreen extends StatefulWidget {
  const SendMoneyConfirmationScreen({super.key});

  @override
  State<SendMoneyConfirmationScreen> createState() =>
      _SendMoneyConfirmationScreenState();
}

class _SendMoneyConfirmationScreenState
    extends State<SendMoneyConfirmationScreen> {
  void finishView() {
    Constant.backToPrev(context);
  }

  FocusNode myFocusNode = FocusNode();
  Color color = greyColor300;
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
          border: Border.all(
              color: greyColor300, width: FetchPixels.getPixelHeight(1)),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButtonWidget("back.svg", context: context),
              getVerSpace(20),
              Center(
                child: getCustomFont("Your’e About to send", 16, grey700, 1,
                    fontWeight: FontWeight.normal),
              ),
              getVerSpace(10),
              currencyAmount(context),
              getVerSpace(10),
              recipientDetails(context),
              getVerSpace(50),
              Center(
                child: getCustomFont(
                    "Enter Pin to Confirm Transaction", 16, grey650, 1,
                    fontWeight: FontWeight.normal),
              ),
              getVerSpace(15),
              Center(
                child: Focus(
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
                    length: 4,
                    focusNode: myFocusNode,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) {
                      Constant.sendToNext(
                          context, Routes.transactionSuccessfulRoute);
                    },
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
              const Spacer(),
              getButton(context, primaryColor, "Send", Colors.white, () {
                Constant.sendToNext(context, Routes.transactionSuccessfulRoute);
              }, 16,
                  weight: FontWeight.w600,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                  buttonHeight: FetchPixels.getPixelHeight(60)),
              getVerSpace(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget currencyAmount(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: getCustomFont("₦", 38, Colors.black, 1,
              fontWeight: FontWeight.w500, letterSpacing: 1.5),
        ),
        getCustomFont(
          "45,000",
          38,
          Colors.black,
          1,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  recipientDetails(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getCustomFont("To", 16, Colors.black, 1,
            fontWeight: FontWeight.w500, letterSpacing: 1.5),
        getHorSpace(6),
        getPngImage("kuda.png", height: 30, width: 30),
        getHorSpace(6),
        getCustomFont("Mamudu Jeffrey", 16, Colors.black, 1,
            fontWeight: FontWeight.w500, letterSpacing: 1.5),
      ],
    );
  }
}
