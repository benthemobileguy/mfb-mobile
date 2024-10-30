import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';
import '../../../profile/presentation/controller/profile_controller.dart';
import '../controller/signup_controller.dart';

class VerifyPhoneNumberScreen extends ConsumerStatefulWidget {
  const VerifyPhoneNumberScreen({super.key});

  @override
  ConsumerState<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState
    extends ConsumerState<VerifyPhoneNumberScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberNode = FocusNode();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    phoneNumberController.addListener(_checkPhoneNumberLength);
  }

  @override
  void dispose() {
    phoneNumberController.removeListener(_checkPhoneNumberLength);
    phoneNumberController.dispose();
    phoneNumberNode.dispose();
    super.dispose();
  }

  void _checkPhoneNumberLength() {
    final input = phoneNumberController.text;
    setState(() {
      isButtonEnabled = input.length >= 11;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileControllerProvider);
    final userProfile = profileController.userProfile;
    phoneNumberController.text = userProfile?.data?.phone ?? "";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
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
                getCustomFont("Verify Phone Number", 18, grey700, 1,
                    fontWeight: FontWeight.w600),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getCustomFont("Tap button below to verify your phone number.",
                    12.5, grey700, 3,
                    fontWeight: FontWeight.normal),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getDefaultTextFiledWithLabel(
                    context, "e.g 08034568944", phoneNumberController,
                    isEnable: false, // Enable the field
                    showCursor: false,
                    focusNode: phoneNumberNode,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    title: "",
                    height: FetchPixels.getPixelHeight(60)),
                const Spacer(),
                getButton(
                    context,
                    isButtonEnabled
                        ? primaryColor
                        : grey400Color, // Color depends on state
                    "Verify Phone Number",
                    Colors.white, () {
                  if (isButtonEnabled) {
                    // Save the phone number in the provider before navigating
                    ref.read(phoneNumberProvider.notifier).state =
                        phoneNumberController.text;
                    ref.read(signUpControllerProvider.notifier).sendPhoneOTP(
                        phoneNumber: phoneNumberController.text,
                        context: context);
                  }
                }, 16,
                    weight: FontWeight.w600,
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                    buttonHeight: FetchPixels.getPixelHeight(60)),
                getVerSpace(FetchPixels.getPixelHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
