import 'package:flutter/material.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class VerifyIdentityScreen extends StatefulWidget {
  const VerifyIdentityScreen({super.key});

  @override
  State<VerifyIdentityScreen> createState() => _VerifyIdentityScreenState();
}

class _VerifyIdentityScreenState extends State<VerifyIdentityScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
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
              getCustomFont("Verify Your Identity", 18, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              getCustomFont(
                  "Please note that this information will be used to verify your identity. Make sure it is accurate.",
                  12.5,
                  grey700,
                  3,
                  fontWeight: FontWeight.normal),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              getDefaultTextFiledWithLabel(
                  context, "Jefferey", firstNameController,
                  isEnable: false,
                  title: "First Name",
                  height: FetchPixels.getPixelHeight(60)),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                context,
                "Mamadu",
                title: "Last Name",
                lastNameController,
                height: FetchPixels.getPixelHeight(60),
                isEnable: false,
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                context,
                "Enter BVN",
                title: "BVN",
                lastNameController,
                height: FetchPixels.getPixelHeight(60),
                isEnable: true,
              ),
              const Spacer(),
              getButton(context, primaryColor, "Verify My Identity", Colors.white, () {
                Navigator.pop(context);
              }, 16,
                  weight: FontWeight.w600,
                  borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                  buttonHeight: FetchPixels.getPixelHeight(60)),
            ],
          ),
        ),
      ),
    );
  }
}
