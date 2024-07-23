import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({super.key});

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  TextEditingController serviceProviderController = TextEditingController();
  TextEditingController packageController = TextEditingController();
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
              appBar(
                context,
                "TV Subscriptions",
              ),
              getVerSpace(20),
              getSvgImage("tv_big.svg", width: 60, height: 60),
              getVerSpace(20),
              getDefaultTextFiledWithLabel(
                context,
                "Select Service Provider",
                title: "Service Provider",
                serviceProviderController,
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
                title: "Package",
                packageController,
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
