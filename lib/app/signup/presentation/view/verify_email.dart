import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:tampay_mobile/app/signup/presentation/controller/signup_controller.dart';
import 'package:tampay_mobile/app/signup/presentation/state/verify_email_state.dart';
import 'package:tampay_mobile/base/pref_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../base/constant.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../theme/color_data.dart';
import '../../../routes/app_routes.dart';
import '../../../view/dialog/verify_dialog.dart';

class VerifyScreen extends ConsumerStatefulWidget {
  const VerifyScreen({super.key});

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends ConsumerState<VerifyScreen> {
  late FocusNode myFocusNode;
  late Color color;
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    color = borderColor;
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verifyEmailState = ref.watch(verifyEmailProvider);

    void finishView() {
      Constant.backToPrev(context);
    }

    final defaultPinTheme = PinTheme(
      width: FetchPixels.getPixelHeight(60),
      height: FetchPixels.getPixelHeight(60),
      textStyle: TextStyle(
        fontSize: FetchPixels.getPixelHeight(24),
        color: grey900Color,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border.all(color: color, width: FetchPixels.getPixelHeight(1)),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
    );

    return WillPopScope(
      onWillPop: () async {
        finishView();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: getPaddingWidget(
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backButtonWidget("back.svg", context: context),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getCustomFont("Verify Email", 22, h6, 1,
                    fontWeight: FontWeight.w600),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text:
                        'We’ve sent you an OTP Code via Email. Please enter the 6-digit code sent to ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.7,
                      fontWeight: FontWeight.w500,
                      fontFamily: Constant.fontsFamily,
                    ),
                    children: [
                      TextSpan(
                        text: verifyEmailState.email,
                        style: TextStyle(
                          color: success2Color,
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: Constant.fontsFamily,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            const url = 'https://example.com/privacy';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            }
                          },
                      ),
                    ],
                  ),
                ),
                getVerSpace(FetchPixels.getPixelHeight(25)),
                getMultilineCustomFont("Enter Code", 13, Colors.black,
                    fontWeight: FontWeight.w400,
                    txtHeight: FetchPixels.getPixelHeight(1.3),
                    textAlign: TextAlign.center),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      color = hasFocus ? greyColor300 : borderColor;
                    });
                  },
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    cursor: Container(),
                    length: 6,
                    focusNode: myFocusNode,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) {
                      ref.read(verifyEmailProvider.notifier).setOtpAndEmail(
                          pin, ref.read(verifyEmailProvider).email);
                      if (pin == verifyEmailState.otp) {
                        _showVerifyDialog(context);
                      } else if (verifyEmailState.otp.isEmpty) {
                        verifyOtpFunction(ref, context);
                      } else {
                        showErrorToast(context, "Invalid OTP entered.");
                      }
                    },
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                getVerSpace(FetchPixels.getPixelHeight(25)),
                InkWell(
                  onTap: () {
                    // Handle resend OTP logic here
                  },
                  child:
                      getCustomFont("Resend code in 50 secs", 12, grey700, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showVerifyDialog(BuildContext context) {
    if (!_dialogShown) {
      _dialogShown = true;

      showDialog(
        barrierDismissible: false,
        builder: (context) {
          return VerifyDialog(
            title: "Account Creation",
            description: "Your account has been successfully created!",
            onOk: () {
              Navigator.of(context).pop(); // Close the dialog
              PrefData.setLogIn(true).then((value) {
                Constant.sendToNext(context, Routes.homeScreenRoute);
              });
              _dialogShown = false; // Reset the flag after dialog is closed
            },
            okText: "Ok",
          );
        },
        context: context,
      ).then((_) {
        // Reset the flag when the dialog is dismissed by other means
        _dialogShown = false;
      });
    }
  }
}

Future<void> verifyOtpFunction(WidgetRef ref, BuildContext context) async {
  await ref.read(signUpControllerProvider).verifyOTP(
        otp: ref.read(verifyEmailProvider).otp,
        email: ref.read(verifyEmailProvider).email,
        context: context,
      );
}
