import 'package:flutter/material.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../../theme/color_data.dart';
import '../routes/app_routes.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void finishView() {
    Constant.closeApp();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  var isPass = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  backButtonWidget("back.svg", context: context),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getCustomFont("Create Account", 22, h6, 1,
                      fontWeight: FontWeight.w600),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getDefaultTextFiledWithLabel(
                      context, "e.g John", firstNameController,
                      isEnable: false,
                      title: "First name",
                      height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getDefaultTextFiledWithLabel(
                      context, "e.g Doe", lastNameController,
                      isEnable: false,
                      title: "Last name",
                      height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(FetchPixels.getPixelHeight(19)),
                  getDefaultTextFiledWithLabel(
                      context, "e.g johndoe@gmail.com", emailController,
                      isEnable: false,
                      title: "Email",
                      height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(FetchPixels.getPixelHeight(19)),
                  getDefaultTextFiledWithLabel(
                      context, "e.g +2348123456789", phoneController,
                      isEnable: false,
                      textInputType: TextInputType.phone,
                      title: "Phone Number",
                      height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(FetchPixels.getPixelHeight(19)),
                  getDefaultTextFiledWithLabel(
                      context, "Enter Referral Code", emailController,
                      isEnable: false,
                      title: "Referral Code (optional)",
                      height: FetchPixels.getPixelHeight(60)),
                  const Spacer(),
                  getButton(context, primaryColor, "Continue", Colors.white,
                      () {
                    Constant.sendToNext(context, Routes.createPassRoute);
                  }, 16,
                      weight: FontWeight.w600,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                      buttonHeight: FetchPixels.getPixelHeight(60)),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }
}
