import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/signup/presentation/controller/forgot_pass-controller.dart';
import 'package:tampay_mobile/app/signup/presentation/controller/signup_controller.dart';
import 'package:tampay_mobile/app/signup/presentation/state/forgot_pass_form_state.dart';
import '../../../../base/constant.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../theme/color_data.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  late TextEditingController emailController;
  FocusNode emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();

    // Add a listener to the emailController to trigger validation
    emailController.addListener(() {
      ref
          .read(forgotPassFormControllerProvider.notifier)
          .updateEmail(emailController.text);
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void finish() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    final resetPassFormState = ref.watch(forgotPassFormControllerProvider);
    bool isFormValid = resetPassFormState.isEmailValid;

    return WillPopScope(
      onWillPop: () async {
        finish();
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
                getCustomFont("Forgot Password", 22, Colors.black, 1,
                    fontWeight: FontWeight.w700),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getMultilineCustomFont(
                  "Please enter the email attached to your account to reset your password",
                  12,
                  Colors.black,
                  fontWeight: FontWeight.w300,
                  txtHeight: FetchPixels.getPixelHeight(1.3),
                  textAlign: TextAlign.start,
                ),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getDefaultTextFiledWithLabel(
                  context,
                  "Email",
                  emailController,
                  isEnable: true,
                  focusNode: emailFocusNode,
                  height: FetchPixels.getPixelHeight(60),
                ),
                if (!isFormValid && emailController.text.isNotEmpty)
                  getCustomFont(
                    resetPassFormState.isEmailValid
                        ? ""
                        : "Please enter a valid email",
                    12,
                    Colors.red,
                    1,
                    fontWeight: FontWeight.w500,
                  ),
                const Spacer(),
                getButton(
                  context,
                  isFormValid ? primaryColor : greyColor300,
                  "Reset Password",
                  Colors.white,
                  isFormValid
                      ? () {
                          _performResetPassword(
                              context, ref, resetPassFormState);
                        }
                      : null,
                  16,
                  weight: FontWeight.w600,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                  buttonHeight: FetchPixels.getPixelHeight(60),
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _performResetPassword(BuildContext context, WidgetRef ref,
      ForgotPasswordFormState resetPassFormState) async {
    // Implement your reset password logic here
    await ref.read(signUpControllerProvider).forgotPassword(
          email: resetPassFormState.email.trim(),
          context: context,
        );
  }
}
