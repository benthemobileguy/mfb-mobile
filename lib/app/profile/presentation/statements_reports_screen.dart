import 'package:flutter/material.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class StatementsReportsScreen extends StatefulWidget {
  const StatementsReportsScreen({super.key});

  @override
  State<StatementsReportsScreen> createState() =>
      _StatementsReportsScreenState();
}

class _StatementsReportsScreenState extends State<StatementsReportsScreen> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController formatController = TextEditingController();
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
              getCustomFont("Statements And Reports", 18, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(FetchPixels.getPixelHeight(16)),
              getSvgImage(
                "statement_icon.svg",
              ),
              getVerSpace(
                FetchPixels.getPixelHeight(10),
              ),
              getCustomFont(
                  "Request a statement between a time frame you specify",
                  13.5,
                  greyColor,
                  3,
                  txtHeight: 1.8,
                  fontWeight: FontWeight.normal),
              getVerSpace(
                FetchPixels.getPixelHeight(20),
              ),
              getDefaultTextFiledWithLabel(
                  context, "29/07/2023", fromController,
                  isEnable: false,
                  title: "From",
                  height: FetchPixels.getPixelHeight(60)),
              const SizedBox(
                height: 20,
              ),
              getDefaultTextFiledWithLabel(context, "29/07/2023", toController,
                  isEnable: false,
                  title: "To",
                  height: FetchPixels.getPixelHeight(60)),
              const SizedBox(
                height: 20,
              ),
              getDefaultTextFiledWithLabel(context, "PDF", formatController,
                  isEnable: false,
                  title: "Format",
                  withSuffix: true,
                  suffixImageWidth: 12,
                  suffixImageHeight: 12,
                  suffixImage: "chevron_down_grey.svg",
                  height: FetchPixels.getPixelHeight(60)),
              const Spacer(),
              getButton(
                  context, primaryColor, "Request Statement", Colors.white, () {
                //  Constant.sendToNext(context, Routes.changePasswordRoute);
                Navigator.pop(context);
              }, 16,
                  weight: FontWeight.w600,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                  buttonHeight: FetchPixels.getPixelHeight(60)),
              const SizedBox(
                height: 13,
              )
            ],
          ),
        ),
      ),
    );
  }
}
