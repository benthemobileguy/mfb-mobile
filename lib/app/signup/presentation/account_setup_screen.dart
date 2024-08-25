import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../theme/color_data.dart';
import '../../view/dialog/verify_dialog.dart';

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
      backgroundColor: colorBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: backButtonWidget("back.svg", context: context),
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: getCustomFont("Account Setup", 18, grey700, 1,
                  fontWeight: FontWeight.w600),
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: getCustomFont(
                  "Complete your account set-up in three simple steps",
                  12.5,
                  grey700,
                  3,
                  fontWeight: FontWeight.normal),
            ),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Row(
                    children: [
                      CircularProgressIndicator(
                        value: 0.4, // 40% progress
                        backgroundColor: yellowBg,
                        valueColor: AlwaysStoppedAnimation<Color>(yellowColor),
                      ),
                      getHorSpace(FetchPixels.getPixelWidth(10)),
                      getCustomFont("40% COMPLETE", 15, h6, 1,
                          fontWeight: FontWeight.w600, letterSpacing: 1.5),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  customListTile("Verify Your Identity", 14, grey700, 1,
                      trailingImagePath: "chevron_right.svg", onTap: () {
                    Constant.sendToNext(context, Routes.verifyIdentityRoute);
                  }),
                  customListTile("Email Verification", 14, grey700, 1,
                      trailingImagePath: "chevron_right.svg", onTap: () {
                    Constant.sendToNext(context, Routes.verifyEmailRoute);
                  }),
                  customListTile("Phone Number", 14, grey700, 1,
                      trailingImagePath: "chevron_right.svg", onTap: () {
                    Constant.sendToNext(context, Routes.verifyPhoneNumberRoute);
                  }),
                  customListTile("Set Transaction Pin", 14, grey700, 1,
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
                              Constant.sendToNext(
                                  context, Routes.setTransactionPinRoute);
                            },
                            okText: "Create Pin",
                          );
                        },
                        context: context);
                  }),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
