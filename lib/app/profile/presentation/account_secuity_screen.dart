import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class AccountSecuityScreen extends StatefulWidget {
  const AccountSecuityScreen({super.key});

  @override
  State<AccountSecuityScreen> createState() => _AccountSecuityScreenState();
}

class _AccountSecuityScreenState extends State<AccountSecuityScreen> {
  bool isSwitched = false;
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
            mainAxisSize: MainAxisSize.min,
            children: [
              backButtonWidget("back.svg", context: context),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getCustomFont("Account Security", 18, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              InkWell(
                onTap: () {
                  Constant.sendToNext(context, Routes.setTransactionPinRoute);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: grey100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      getCustomFont("Reset Passcode", 14.5, h6, 1,
                          fontWeight: FontWeight.normal),
                      const Spacer(),
                      getCustomFont("Reset", 13, greyColor, 1,
                          fontWeight: FontWeight.normal),
                    ],
                  ),
                ),
              ),
              getVerSpace(14),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: grey100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      getCustomFont("Enable Biometric login", 14.5, h6, 1,
                          fontWeight: FontWeight.normal),
                      const Spacer(),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        thumbColor: WidgetStateProperty.all(Colors.white),
                        activeColor: switchColor,
                      ),
                    ],
                  ),
                ),
              ),
              getVerSpace(14),
              InkWell(
                onTap: () {
                  Constant.sendToNext(context, Routes.setTransactionPinRoute);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: grey100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      getCustomFont("Change Transaction PIN", 14.5, h6, 1,
                          fontWeight: FontWeight.normal),
                      const Spacer(),
                      getCustomFont("Reset", 13, greyColor, 1,
                          fontWeight: FontWeight.normal),
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
