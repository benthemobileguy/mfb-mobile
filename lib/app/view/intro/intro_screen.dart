import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tampay_mobile/app/data/data_file.dart';
import 'package:tampay_mobile/base/pref_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../theme/color_data.dart';
import '../../models/intro_model.dart';
import '../../routes/app_routes.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  ValueNotifier selectedPage = ValueNotifier(0);
  final _controller = PageController();

  List<ModelIntro> introLists = DataFile.introList;
  int select = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(
                  top: FetchPixels.getPixelHeight(30),
                ),
                child: getAssetImage("logo_dark.png", width: 50, height: 50),
              ),
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) {
                    selectedPage.value = value;
                    setState(() {
                      select = value;
                    });
                  },
                  itemCount: introLists.length,
                  itemBuilder: (context, index) {
                    ModelIntro introModel = introLists[index];
                    return Stack(
                      children: [
                        Positioned(
                          top: FetchPixels.getPixelHeight(-160),
                          left: 0,
                          right: 0,
                          child: Lottie.asset(
                            introModel.lottieImage!,
                            repeat: false,
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: FetchPixels.getPixelHeight(80),
                          right: FetchPixels.getPixelHeight(0),
                          left: FetchPixels.getPixelHeight(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  getVerSpace(FetchPixels.getPixelHeight(40)),
                                  getCustomFont(introModel.title ?? "", 18,
                                      Colors.black, 1,
                                      fontWeight: FontWeight.w600),
                                  getVerSpace(FetchPixels.getPixelHeight(13)),
                                  getPaddingWidget(
                                    EdgeInsets.symmetric(
                                        horizontal:
                                            FetchPixels.getPixelHeight(30)),
                                    getMultilineCustomFont(
                                        introModel.description ?? "",
                                        14,
                                        Colors.black,
                                        fontWeight: FontWeight.w400,
                                        textAlign: TextAlign.center,
                                        txtHeight:
                                            FetchPixels.getPixelHeight(1.3)),
                                  ),
                                  getVerSpace(FetchPixels.getPixelHeight(10)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      introLists.length,
                                      (position) {
                                        return getPaddingWidget(
                                            EdgeInsets.symmetric(
                                                horizontal:
                                                    FetchPixels.getPixelHeight(
                                                        3)),
                                            getSvgImage(position == select
                                                ? "selected_dot.svg"
                                                : "dot.svg"));
                                      },
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginButton(context),
                    getHorSpace(FetchPixels.getPixelWidth(30)),
                    signUpButton(context),
                  ],
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(35)),
            ],
          ),
        ),
      ),
    );
  }

  loginButton(BuildContext context) {
    return getButton(context, Colors.transparent, "Login", grey700, () {
      PrefData.setIsOnboardingCompleted(true).then((value) {
        Constant.sendToNext(context, Routes.loginRoute);
      });
    }, 16,
        weight: FontWeight.w600,
        buttonWidth: MediaQuery.of(context).size.width * 0.35,
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(16)),
        buttonHeight: FetchPixels.getPixelHeight(60),
        isBorder: true,
        borderColor: grey700,
        borderWidth: FetchPixels.getPixelHeight(2));
  }

  signUpButton(BuildContext context) {
    return getButton(context, primaryColor, "Sign Up", Colors.white, () {
      PrefData.setIsOnboardingCompleted(true).then(
        (value) {
          Constant.sendToNext(context, Routes.signupRoute);
        },
      );
    }, 16,
        weight: FontWeight.w600,
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(16)),
        buttonHeight: FetchPixels.getPixelHeight(60),
        isBorder: true,
        buttonWidth: MediaQuery.of(context).size.width * 0.35,
        borderColor: primaryColor,
        borderWidth: FetchPixels.getPixelHeight(2));
  }
}
