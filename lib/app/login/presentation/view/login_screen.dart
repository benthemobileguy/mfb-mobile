import 'package:flutter/material.dart';
import '../../../../base/constant.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../theme/color_data.dart';
import '../../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void finishView() {
    Constant.closeApp();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isPass = false;

  @override
  Widget build(BuildContext context) {
    // FetchPixels(context);
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
                  getCustomFont("Login", 22, h6, 1,
                      fontWeight: FontWeight.w600),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getDefaultTextFiledWithLabel(
                      context, "e.g Johndoe@gmail.com", emailController,
                      isEnable: false,
                      title: "Email",
                      height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  getDefaultTextFiledWithLabel(
                      context,
                      "Enter Password",
                      title: "Password",
                      passwordController,
                      height: FetchPixels.getPixelHeight(60),
                      withSuffix: true,
                      suffixImage: "eye.svg",
                      isEnable: false,
                      isPass: isPass, imageFunction: () {
                    setState(() {
                      !isPass ? isPass = true : isPass = false;
                    });
                  }),
                  getVerSpace(FetchPixels.getPixelHeight(19)),
                  GestureDetector(
                    onTap: () {},
                    child: InkWell(
                      onTap: () {
                        Constant.sendToNext(context, Routes.forgotPassRoute);
                      },
                      child: getCustomFont(
                          "Forgot Password?", 13, greenSuccessColor, 1,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.end),
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  const Spacer(),
                  getButton(context, primaryColor, "Login", Colors.white, () {
                    Constant.sendToNext(context, Routes.homeScreenRoute);
                  }, 16,
                      weight: FontWeight.w600,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                      buttonHeight: FetchPixels.getPixelHeight(60)),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getCustomFont("Don’t have an account? ", 15, greyColor, 1,
                          fontWeight: FontWeight.w500),
                      GestureDetector(
                        onTap: () {
                          Constant.sendToNext(context, Routes.signupRoute);
                        },
                        child: getCustomFont(
                            "Create Account", 15, success2Color, 1,
                            fontWeight: FontWeight.w500),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(60)),
                    ],
                  ),
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
