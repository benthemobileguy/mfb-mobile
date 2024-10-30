import 'package:flutter/material.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

import '../../../../../../base/constant.dart';
import '../../../../../routes/app_routes.dart';

class AirtimeScreen extends StatefulWidget {
  const AirtimeScreen({super.key});

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  TextEditingController selectNetworkProviderController =
      TextEditingController();
  TextEditingController recipientPhoneNumberController =
      TextEditingController();
  TextEditingController amountController = TextEditingController();
  final List<Map<String, String>> phoneNumbers = [
    {'number': '08100699608', 'icon': 'mtn.png'},
    {'number': '07083456455', 'icon': 'airtel.png'},
    {'number': '08056589877', 'icon': 'glo.png'},
    {'number': '08140699608', 'icon': 'mtn.png'},
    {'number': '07056789855', 'icon': 'glo.png'},
  ];
  final List<String> amounts = [
    '100',
    '200',
    '500',
    '1000',
  ];

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
              appBar(context),
              getVerSpace(20),
              getSvgImage("airtime_big.svg", width: 60, height: 60),
              getVerSpace(20),
              getCustomFont("Frequently Recharged", 15, Colors.black, 1,
                  fontWeight: FontWeight.w500),
              getVerSpace(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: phoneNumbers.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 10), // Space between items
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: grey100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              getPngImage(item['icon']!, width: 24, height: 24),
                              const SizedBox(width: 10),
                              getCustomFont(
                                  item['number']!, 14, Colors.black, 1,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              getVerSpace(30),
              getCustomFont("Quick Prices", 15, Colors.black, 1,
                  fontWeight: FontWeight.w500),
              getVerSpace(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: amounts.map((amount) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: grey100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: getCustomFont("₦$amount", 13, Colors.black, 1,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              getVerSpace(20),
              getDefaultTextFiledWithLabel(
                context,
                "Select network provider",
                title: "Network Provider",
                selectNetworkProviderController,
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
                "Enter phone number",
                title: "Recipient's Number",
                recipientPhoneNumberController,
                height: FetchPixels.getPixelHeight(60),
                withSuffix: false,
                suffixImageHeight: 12,
                suffixImageWidth: 12,
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
              getVerSpace(20),
              balance(context),
              const Spacer(),
              getButton(context, primaryColor, "Buy airtime", Colors.white, () {
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

  Widget appBar(BuildContext context) {
    return Row(
      children: [
        backButtonWidget("back.svg", context: context),
        const Spacer(),
        Center(
          child: getCustomFont("Airtime", 15, Colors.black, 1,
              fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        getHorSpace(55)
      ],
    );
  }
}
