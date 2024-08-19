import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../../theme/color_data.dart';
import '../view/dialog/verify_dialog.dart';

class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  void finishView() {
    Constant.closeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButtonWidget("back.svg", context: context),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getCustomFont("Account Setup", 18, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              getCustomFont(
                  "Complete your account set-up in three simple steps",
                  14,
                  grey700,
                  3,
                  fontWeight: FontWeight.w600),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              getCustomFont("40% COMPLETE", 15, h6, 1,
                  fontWeight: FontWeight.w600, letterSpacing: 1.5),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              customListTile("BVN Verification", 14, grey700, 1,
                  trailingImagePath: "chevron_right.svg", onTap: () {
                showDialog(
                    barrierDismissible: true,
                    builder: (context) {
                      return VerifyDialog(
                        title: "Set Transaction Pin",
                        imagePath: "lock.svg",
                        description:
                            "This PIN will help us verify your identity to authorize transactions from your Tampay account.",
                        onOk: () {
                          Navigator.pop(context);
                          Constant.sendToNext(context, Routes.setTransactionPinRoute);
                        },
                        okText: "Create Pin",
                      );
                    },
                    context: context);
              }),
              customListTile("Email Verification", 14, grey700, 1,
                  trailingImagePath: "chevron_right.svg", onTap: () {
                showDialog(
                    barrierDismissible: true,
                    builder: (context) {
                      return VerifyDialog(
                        title: "Set Transaction Pin",
                        imagePath: "lock.svg",
                        description:
                            "This PIN will help us verify your identity to authorize transactions from your Tampay account.",
                        onOk: () {
                          Navigator.pop(context);
                          Constant.sendToNext(context, Routes.setTransactionPinRoute);
                        },
                        okText: "Create Pin",
                      );
                    },
                    context: context);
              }),
              customListTile("Phone Number", 14, grey700, 1,
                  trailingImagePath: "chevron_right.svg", onTap: () {
                showDialog(
                    barrierDismissible: true,
                    builder: (context) {
                      return VerifyDialog(
                        title: "Set Transaction Pin",
                        imagePath: "lock.svg",
                        description:
                            "This PIN will help us verify your identity to authorize transactions from your Tampay account.",
                        onOk: () {
                          Navigator.pop(context);
                          Constant.sendToNext(context, Routes.setTransactionPinRoute);
                        },
                        okText: "Create Pin",
                      );
                    },
                    context: context);
              }),
              customListTile("Set Pin", 14, grey700, 1,
                  trailingImagePath: "chevron_right.svg", onTap: () {
                showDialog(
                    barrierDismissible: true,
                    builder: (context) {
                      return VerifyDialog(
                        title: "Set Transaction Pin",
                        imagePath: "lock.svg",
                        description:
                            "This PIN will help us verify your identity to authorize transactions from your Tampay account.",
                        onOk: () {
                          Navigator.pop(context);
                          Constant.sendToNext(context, Routes.setTransactionPinRoute);
                        },
                        okText: "Create Pin",
                      );
                    },
                    context: context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
