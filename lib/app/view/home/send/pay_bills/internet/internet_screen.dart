import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/theme/color_data.dart';

import '../../../../../../base/widget_utils.dart';

class InternetScreen extends StatefulWidget {
  const InternetScreen({super.key});

  @override
  State<InternetScreen> createState() => _InternetScreenState();
}

class _InternetScreenState extends State<InternetScreen> {
  TextEditingController networkProviderController = TextEditingController();
  TextEditingController planController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context, "Buy Data"),
              getVerSpace(20),
              getSvgImage("data_big.svg", width: 60, height: 60),
              getVerSpace(20),
              getDefaultTextFiledWithLabel(
                context,
                "Select Network Provider",
                title: "Network Provider",
                networkProviderController,
                height: FetchPixels.getPixelHeight(60),
                withSuffix: true,
                suffixImageHeight: 12,
                suffixImageWidth: 12,
                suffixImage: "chevron_down_dark.svg",
                isEnable: true,
              ),
              getVerSpace(20),
              getDefaultTextFiledWithLabel(
                context,
                "Select data plan",
                title: "Plan",
                planController,
                height: FetchPixels.getPixelHeight(60),
                withSuffix: true,
                suffixImageHeight: 12,
                suffixImageWidth: 12,
                suffixImage: "chevron_down_dark.svg",
                isEnable: true,
              ),
              const Spacer(),
              getButton(context, primaryColor, "Buy Data", Colors.white, () {
                Constant.sendToNext(context, Routes.sendMoneyConfirmationRoute);
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
}
