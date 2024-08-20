import 'package:flutter/material.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
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
              getCustomFont("Support", 18, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              GestureDetector(
                onTap: () {
                  showToast(context, "Coming soon");
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: grey100,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(18))),
                  child: Row(
                    children: [
                      getSvgImage("call.svg"),
                      getHorSpace(FetchPixels.getPixelWidth(16)),
                      getCustomFont("Call Tampay", 14.5, h6, 1),
                      const Spacer(),
                      getCustomFont("Call", 14.5, greyColor, 1),
                    ],
                  ),
                ),
              ),
              getVerSpace(16),
              GestureDetector(
                onTap: () {
                  showToast(context, "Coming soon");
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: grey100,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(18))),
                  child: Row(
                    children: [
                      getSvgImage("live_chat.svg"),
                      getHorSpace(FetchPixels.getPixelWidth(16)),
                      getCustomFont("Live Chat", 14.5, h6, 1),
                      const Spacer(),
                      getCustomFont("Start Chat", 14.5, greyColor, 1),
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
