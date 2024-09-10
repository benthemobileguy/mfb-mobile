import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/signup/presentation/controller/signup_form_controller.dart';
import 'package:tampay_mobile/app/signup/presentation/state/signup_form_state.dart';
import 'package:tampay_mobile/app/signup/presentation/state/verify_email_state.dart';
import 'package:tampay_mobile/app/signup/presentation/view/widgets/pass_condition.dart';
import '../../../../base/constant.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../theme/color_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/signup_controller.dart';

class CreateNewPasswordScreen extends ConsumerStatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  ConsumerState<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState
    extends ConsumerState<CreateNewPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  var isPass = false;
  var isConfirmPass = false;

  @override
  void initState() {
    super.initState();
    final signUpFormState = ref.read(signUpFormControllerProvider);

    passwordController.text = signUpFormState.password;
    confirmPasswordController.text = signUpFormState.confirmPassword;

    passwordController.addListener(() {
      ref
          .read(signUpFormControllerProvider.notifier)
          .updatePassword(passwordController.text);
    });

    confirmPasswordController.addListener(() {
      ref
          .read(signUpFormControllerProvider.notifier)
          .updateConfirmPassword(confirmPasswordController.text);
    });
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();

    // Optionally reset the form state if the widget is still mounted
    if (mounted) {
      ref.read(signUpFormControllerProvider.notifier).resetForm();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sign_up_form_state = ref.watch(signUpFormControllerProvider);
    bool isFormValid = sign_up_form_state.isPasswordValid &&
        sign_up_form_state.isConfirmPasswordValid;

    return WillPopScope(
      onWillPop: () async {
        Constant.closeApp();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      backButtonWidget("back.svg", context: context),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      getCustomFont("Create New Password", 22, h6, 1,
                          fontWeight: FontWeight.w600),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      getDefaultTextFiledWithLabel(
                          context,
                          "Enter Password",
                          title: "Password",
                          passwordController,
                          focusNode: passwordFocusNode,
                          textInputType: TextInputType.visiblePassword,
                          height: FetchPixels.getPixelHeight(60),
                          withSuffix: true,
                          suffixImage: isPass ? "eye.svg" : "eye_slash.svg",
                          isEnable: true,
                          isPass: !isPass, imageFunction: () {
                        setState(() {
                          isPass = !isPass;
                        });
                      }),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      getDefaultTextFiledWithLabel(
                          context,
                          "Enter Password",
                          title: "Confirm Password",
                          focusNode: confirmPasswordFocusNode,
                          confirmPasswordController,
                          textInputType: TextInputType.visiblePassword,
                          height: FetchPixels.getPixelHeight(60),
                          withSuffix: true,
                          suffixImage:
                              isConfirmPass ? "eye.svg" : "eye_slash.svg",
                          isEnable: true,
                          isPass: !isConfirmPass, imageFunction: () {
                        setState(() {
                          isConfirmPass = !isConfirmPass;
                        });
                      }),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      getCustomFont(
                          "PASSWORD MUST CONTAIN AT LEAST", 14.5, grey800, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(14)),
                      PassCondition(
                        title: "8 characters",
                        isMet: sign_up_form_state.hasMinLength,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      PassCondition(
                        title: "One uppercase letter",
                        isMet: sign_up_form_state.hasUppercase,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      PassCondition(
                        title: "One number",
                        isMet: sign_up_form_state.hasDigits,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      PassCondition(
                        title: "One Special Character e.g !^@*#(",
                        isMet: sign_up_form_state.hasSpecialCharacters,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getButton(
                          context,
                          isFormValid ? primaryColor : greyColor300,
                          "Create Account",
                          Colors.white,
                          isFormValid
                              ? () async {
                                  await _performCreateAccount(
                                      context, ref, sign_up_form_state);
                                }
                              : null,
                          16,
                          weight: FontWeight.w600,
                          borderRadius: BorderRadius.circular(
                              FetchPixels.getPixelHeight(15)),
                          buttonHeight: FetchPixels.getPixelHeight(60)),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'By creating an account, you agree to Tampay’s ',
                            style: TextStyle(
                              color: grey400Color,
                              fontSize: 14,
                              height: 1.7,
                              fontWeight: FontWeight.w500,
                              fontFamily: Constant.fontsFamily,
                            ),
                            children: [
                              TextSpan(
                                text: 'Privacy Policy',
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
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(
                                  color: success2Color,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Constant.fontsFamily,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    const url = 'https://example.com/terms';
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(Uri.parse(url));
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _performCreateAccount(BuildContext context, WidgetRef ref,
      SignUpFormState signUpFormState) async {
    if (mounted) {
      if (signUpFormState.phone.isEmpty) {
        await ref.read(signUpControllerProvider).createNewPassword(
              otp: ref.read(verifyEmailProvider).otp,
              email: ref.read(verifyEmailProvider).email,
              newPassword: passwordController.text.trim(),
              confirmPassword: confirmPasswordController.text.trim(),
              context: context,
            );
      } else {
        await ref.read(signUpControllerProvider).createAccount(
              email: signUpFormState.email.trim(),
              firstName: signUpFormState.firstName.trim(),
              lastName: signUpFormState.lastName.trim(),
              password: passwordController.text.trim(),
              confirmPassword: confirmPasswordController.text.trim(),
              phone: "+234${signUpFormState.phone.trim().substring(1)}",
              referralCode: signUpFormState.referralCode.trim(),
              context: context,
            );
      }
    }
  }
}
