import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController convertedAmountController = TextEditingController();

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dragIndicator(context),
              const SizedBox(height: 16),
              Text(
                "Select Account",
                style: TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.bold,
                  color: grey700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Select account to top up from",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: grey700,
                ),
              ),
              getVerSpace(16),
              _buildAccountRow(
                  "usd_logo.svg", "United States Dollar (USD)", "£500"),
              _buildAccountRow(
                  "britain_logo.svg", "Great British Pound (GBP)", "\$1,200"),
              _buildAccountRow(
                  "cad_dollar_logo.svg", "Canadian Dollar (CAD)", "C800"),
              getVerSpace(16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountRow(String icon, String name, String amount) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            getSvgImage(icon, width: 30, height: 30),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14.5,
                  fontFamily: Constant.fontsFamily,
                  fontWeight: FontWeight.normal,
                  color: grey650,
                ),
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontSize: 14.5,
                fontFamily: Constant.fontsFamily,
                fontWeight: FontWeight.w600,
                color: greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              getCustomFont("Add Money", 22, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(20),
              getDefaultTextFiledWithLabel(
                context,
                "₦0.00",
                onTap: () {
                  _showBottomSheet(context);
                },
                title: "Enter Amount",
                amountController,
                height: FetchPixels.getPixelHeight(60),
                withSuffix: true,
                withPrefix: true,
                suffixImage: "chevron_down_grey.svg",
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
                isEnable: false,
                height: FetchPixels.getPixelHeight(60),
                withSuffix: false,
                withPrefix: false,
                image: "britain_logo.svg",
                suffixImageHeight: 10,
                suffixImageWidth: 10,
              ),
              const Spacer(),
              getButton(context, primaryColor, "Convert", Colors.white, () {
                Constant.sendToNext(context, Routes.fundingSuccessRoute);
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
