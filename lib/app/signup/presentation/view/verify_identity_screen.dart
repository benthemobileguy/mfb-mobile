import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';
import '../../../profile/domain/model/response/user_profile.dart';
import '../../../profile/presentation/controller/profile_controller.dart';
import '../controller/signup_controller.dart';
import '../controller/verify_identity_form_controller.dart';

class VerifyIdentityScreen extends ConsumerWidget {
  const VerifyIdentityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formController = ref.watch(verifyIdentityFormProvider);
    Future.microtask(() {
      final profileController = ref.read(profileControllerProvider);
      final userProfile = profileController.userProfile ?? UserProfile();
      final formController = ref.read(verifyIdentityFormProvider);

      formController.firstNameController.text =
          userProfile.data?.firstName ?? "";
      formController.lastNameController.text = userProfile.data?.lastName ?? "";
      formController.bvnFocusNode.requestFocus();
    });
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

              // First Name Field
              getDefaultTextFiledWithLabel(
                  context, "Jefferey", formController.firstNameController,
                  isEnable: false, // Set to true so user can change if needed
                  focusNode: formController.firstNameFocusNode,
                  title: "First Name",
                  height: FetchPixels.getPixelHeight(60)),
              getVerSpace(FetchPixels.getPixelHeight(20)),

              // Last Name Field
              getDefaultTextFiledWithLabel(
                context,
                "Mamadu",
                title: "Last Name",
                focusNode: formController.lastNameFocusNode,
                formController.lastNameController,
                height: FetchPixels.getPixelHeight(60),
                isEnable: false, // Set to true so user can change if needed
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),

              // BVN Field
              getDefaultTextFiledWithLabel(
                context,
                "Enter BVN",
                title: "BVN",
                formController.bvnController,
                focusNode: formController.bvnFocusNode,
                height: FetchPixels.getPixelHeight(60),
                isEnable: true,
              ),
              const Spacer(),

              // Verify My Identity Button (Disabled until form is valid)
              getButton(
                  context,
                  formController.isFormValid
                      ? primaryColor
                      : greyColor300, // Change color based on form validity
                  "Verify My Identity",
                  Colors.white,
                  formController.isFormValid
                      ? () {
                          // Call the verifyIdentity method when button is clicked
                          ref
                              .read(signUpControllerProvider.notifier)
                              .sendBvnPhoneOTP(
                                  bvn: formController.bvnController.text,
                                  firstName:
                                      formController.firstNameController.text,
                                  lastName:
                                      formController.lastNameController.text,
                                  context: context);
                        }
                      : null, // Disable button if form is invalid
                  16,
                  weight: FontWeight.w600,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                  buttonHeight: FetchPixels.getPixelHeight(60)),

              getVerSpace(FetchPixels.getPixelHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}

// Riverpod provider for the form controller
final verifyIdentityFormProvider =
    ChangeNotifierProvider<VerifyIdentityFormController>((ref) {
  return VerifyIdentityFormController();
});
