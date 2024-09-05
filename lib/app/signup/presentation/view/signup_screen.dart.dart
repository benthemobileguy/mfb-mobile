import 'package:flutter/material.dart';
import '../../../../base/constant.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../theme/color_data.dart';
import '../../../routes/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/signup/presentation/controller/signup_form_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode referralCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final signUpFormState = ref.read(signUpFormControllerProvider);

    firstNameController.text = signUpFormState.firstName;
    lastNameController.text = signUpFormState.lastName;
    emailController.text = signUpFormState.email;
    phoneController.text = signUpFormState.phone;
    referralCodeController.text = signUpFormState.referralCode;

    firstNameController.addListener(() {
      ref
          .read(signUpFormControllerProvider.notifier)
          .updateFirstName(firstNameController.text);
    });

    lastNameController.addListener(() {
      ref
          .read(signUpFormControllerProvider.notifier)
          .updateLastName(lastNameController.text);
    });

    emailController.addListener(() {
      ref
          .read(signUpFormControllerProvider.notifier)
          .updateEmail(emailController.text);
    });

    phoneController.addListener(() {
      ref
          .read(signUpFormControllerProvider.notifier)
          .updatePhone(phoneController.text);
    });

    referralCodeController.addListener(() {
      ref
          .read(signUpFormControllerProvider.notifier)
          .updateReferralCode(referralCodeController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final signUpFormState = ref.watch(signUpFormControllerProvider);

    bool isFormValid = signUpFormState.isFirstNameValid &&
        signUpFormState.isLastNameValid &&
        signUpFormState.isEmailValid &&
        signUpFormState.isPhoneValid;

    return WillPopScope(
      onWillPop: () async {
        Constant.closeApp();
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
                backButtonWidget("back.svg", context: context),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getCustomFont("Create Account", 22, h6, 1,
                    fontWeight: FontWeight.w600),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getDefaultTextFiledWithLabel(
                    context, "e.g John", firstNameController,
                    isEnable: true,
                    focusNode: firstNameFocusNode,
                    title: "First name",
                    height: FetchPixels.getPixelHeight(60)),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getDefaultTextFiledWithLabel(
                    context, "e.g Doe", lastNameController,
                    isEnable: true,
                    title: "Last name",
                    focusNode: lastNameFocusNode,
                    height: FetchPixels.getPixelHeight(60)),
                getVerSpace(FetchPixels.getPixelHeight(19)),
                getDefaultTextFiledWithLabel(
                    context, "e.g johndoe@gmail.com", emailController,
                    isEnable: true,
                    focusNode: emailFocusNode,
                    title: "Email",
                    height: FetchPixels.getPixelHeight(60)),
                getVerSpace(FetchPixels.getPixelHeight(19)),
                getDefaultTextFiledWithLabel(
                    context, "e.g 08123456789", phoneController,
                    isEnable: true,
                    maxLength: 11,
                    focusNode: phoneFocusNode,
                    textInputType: TextInputType.phone,
                    title: "Phone Number",
                    height: FetchPixels.getPixelHeight(60)),
                getVerSpace(FetchPixels.getPixelHeight(19)),
                getDefaultTextFiledWithLabel(
                    context, "Enter Referral Code", referralCodeController,
                    isEnable: true,
                    focusNode: referralCodeFocusNode,
                    title: "Referral Code (optional)",
                    height: FetchPixels.getPixelHeight(60)),
                getVerSpace(FetchPixels.getPixelHeight(40)),
                getButton(context, isFormValid ? primaryColor : greyColor300,
                    "Continue", Colors.white, () {
                  if (isFormValid) {
                    Constant.sendToNext(context, Routes.createPassRoute);
                  }
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
    );
  }
}
