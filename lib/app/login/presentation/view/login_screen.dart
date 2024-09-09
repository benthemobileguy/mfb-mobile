import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/login/presentation/controller/login_controller.dart';
import 'package:tampay_mobile/app/login/presentation/controller/login_form_controller.dart';
import 'package:tampay_mobile/app/login/presentation/state/login_form_state.dart';
import '../../../../base/constant.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../theme/color_data.dart';
import '../../../routes/app_routes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final loginFormState = ref.read(loginFormControllerProvider);

    // Initialize controllers with initial values
    _emailController = TextEditingController(text: loginFormState.email);
    _passwordController = TextEditingController(text: loginFormState.password);

    // Add listeners to update state when the text changes
    _emailController.addListener(() {
      ref
          .read(loginFormControllerProvider.notifier)
          .updateEmail(_emailController.text);
    });

    _passwordController.addListener(() {
      ref
          .read(loginFormControllerProvider.notifier)
          .updatePassword(_passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginFormState = ref.watch(loginFormControllerProvider);
    bool isFormValid =
        loginFormState.isEmailValid && loginFormState.isPasswordValid;

    return WillPopScope(
      onWillPop: () async {
        finishView();
        return false;
      },
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
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getCustomFont("Login", 22, h6, 1, fontWeight: FontWeight.w600),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getDefaultTextFiledWithLabel(
                  context,
                  "e.g Johndoe@gmail.com",
                  _emailController,
                  isEnable: true,
                  focusNode: _emailFocusNode,
                  title: "Email",
                  height: FetchPixels.getPixelHeight(60),
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getDefaultTextFiledWithLabel(
                  context,
                  "Enter Password",
                  _passwordController,
                  isEnable: true,
                  focusNode: _passwordFocusNode,
                  title: "Password",
                  imageFunction: () {
                    // Toggle password visibility
                    ref
                        .read(loginFormControllerProvider.notifier)
                        .togglePasswordVisibility();
                  },
                  height: FetchPixels.getPixelHeight(60),
                  withSuffix: true,
                  suffixImage: loginFormState.isPasswordVisible
                      ? "eye.svg"
                      : "eye_slash.svg",
                  isPass: !loginFormState.isPasswordVisible,
                ),
                getVerSpace(FetchPixels.getPixelHeight(19)),
                GestureDetector(
                  onTap: () {
                    Constant.sendToNext(context, Routes.forgotPassRoute);
                  },
                  child: getCustomFont(
                    "Forgot Password?",
                    13,
                    greenSuccessColor,
                    1,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.end,
                  ),
                ),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                const Spacer(),
                getButton(
                  context,
                  isFormValid ? primaryColor : greyColor300,
                  "Login",
                  Colors.white,
                  isFormValid
                      ? () async {
                          await _performLogin(context, ref, loginFormState);
                        }
                      : null, // Disable button if conditions aren't met
                  16,
                  weight: FontWeight.w600,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                  buttonHeight: FetchPixels.getPixelHeight(60),
                ),
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
    );
  }

  Future<void> _performLogin(BuildContext context, WidgetRef ref,
      LoginFormState loginFormState) async {
    await ref.read(loginControllerProvider).login(
        email: loginFormState.email.trim(),
        password: loginFormState.password.trim(),
        context: context);
  }

  @override
  void dispose() {
    // Dispose controllers
    _emailController.dispose();
    _passwordController.dispose();
    // Reset the login form state
    ref.read(loginFormControllerProvider.notifier).resetForm();
    super.dispose();
  }

  void finishView() {
    Constant.closeApp();
  }
}
