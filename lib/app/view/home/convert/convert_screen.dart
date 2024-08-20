import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({super.key});

  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController convertedAmountController = TextEditingController();
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
                "",
              ),
              getVerSpace(16),
              getCustomFont("Convert", 22, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(20),
              getDefaultTextFiledWithLabel(
                context,
                "₦0.00",
                title: "Enter Amount",
                amountController,
                height: FetchPixels.getPixelHeight(60),
                withSuffix: false,
                withPrefix: true,
                image: "britain_logo.svg",
                suffixImageHeight: 12,
                suffixImageWidth: 12,
                isEnable: false,
              ),
              getVerSpace(10),
              getCustomFont("Balance :£16.30", 14.5, grey650, 1,
                  fontWeight: FontWeight.normal),
              getVerSpace(30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getSvgImage("stroke.svg"),
                  getHorSpace(10),
                  getSvgImage("flash.svg"),
                  getHorSpace(5),
                  getCustomFont("Rate :£1=\$1.26", 14, grey700, 1,
                      fontWeight: FontWeight.normal),
                  getHorSpace(5),
                  getSvgImage("stroke.svg"),
                ],
              ),
              getVerSpace(30),
              getDefaultTextFiledWithLabel(
                context,
                "₦0.00",
                title: "You'll get",
                convertedAmountController,
                suffixImage: "chevron_down_grey.svg",
                isEnable: false,
                height: FetchPixels.getPixelHeight(60),
                withSuffix: true,
                withPrefix: true,
                image: "ngn_logo.svg",
                suffixImageHeight: 10,
                suffixImageWidth: 10,
              ),
              const Spacer(),
              getButton(context, primaryColor, "Convert", Colors.white, () {
                Constant.sendToNext(context, Routes.conversionSuccessRoute);
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
