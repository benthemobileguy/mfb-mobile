import 'package:flutter/material.dart';
import '../../../../../../base/constant.dart';
import '../../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../../base/widget_utils.dart';
import '../../../../../../theme/color_data.dart';
import '../../../../../routes/app_routes.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {
  TextEditingController electricityProviderController = TextEditingController();
  TextEditingController packageController = TextEditingController();
  TextEditingController meterNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
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
                "Pay Electricity Bills",
              ),
              getVerSpace(20),
              getSvgImage("bulb.svg", width: 60, height: 60),
              getVerSpace(20),
              getDefaultTextFiledWithLabel(
                context,
                "Select Electricity Provider",
                title: "Electricity Provider",
                electricityProviderController,
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
                "Select package",
                title: "Package",
                packageController,
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
                "Enter meter number",
                title: "Meter Number",
                meterNumberController,
                height: FetchPixels.getPixelHeight(60),
                withSuffix: false,
                suffixImageHeight: 12,
                suffixImageWidth: 12,
                suffixImage: "chevron_down_dark.svg",
                isEnable: false,
              ),
              getVerSpace(20),
              getDefaultTextFiledWithLabel(
                context,
                "₦0.00",
                title: "Amount",
                amountController,
                height: FetchPixels.getPixelHeight(60),
                withSuffix: false,
                suffixImageHeight: 12,
                suffixImageWidth: 12,
                isEnable: false,
              ),
              getVerSpace(10),
              balance(context),
              const Spacer(),
              getButton(context, primaryColor, "Pay Bill", Colors.white, () {
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
