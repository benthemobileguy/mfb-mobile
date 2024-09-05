import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  const VerifyPhoneNumberScreen({super.key});

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberNode = FocusNode();
  void finishView() {
    Constant.closeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                backButtonWidget("back.svg", context: context),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getCustomFont("Verify Phone Number", 18, grey700, 1,
                    fontWeight: FontWeight.w600),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getCustomFont("Enter phone number to verify.", 12.5, grey700, 3,
                    fontWeight: FontWeight.normal),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getDefaultTextFiledWithLabel(
                    context, "e.g 08034568944", phoneNumberController,
                    isEnable: false,
                    focusNode: phoneNumberNode,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    title: "",
                    height: FetchPixels.getPixelHeight(60)),
                const Spacer(),
                getButton(
                    context, primaryColor, "Verify Phone Number", Colors.white,
                    () {
                  Constant.sendToNext(
                      context, Routes.verifyPhoneConfirmationRoute);
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
    );
  }
}
