import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import '../../../../base/constant.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../theme/color_data.dart';
import '../../../profile/presentation/controller/profile_controller.dart';
import '../../../view/dialog/verify_dialog.dart';

class AccountSetupScreen extends ConsumerStatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  ConsumerState<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends ConsumerState<AccountSetupScreen> {
  void finishView() {
    Constant.closeApp();
  }

  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileControllerProvider);
    final userProfile = profileController.userProfile;
    final accountCompletion =
        (userProfile?.data?.accountCompletionStatus ?? 0) / 100;

    bool emailVerified = userProfile?.data?.emailVerified ?? false;
    bool phoneNumberVerified = userProfile?.data?.phoneNumberVerified ?? false;
    bool passcodeSet = userProfile?.data?.passCode != null;
    bool pinSet = userProfile?.data?.pin != null;
    bool bvnVerified = userProfile?.data?.bvnVerified ?? false;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: backButtonWidget("back.svg", context: context),
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: getCustomFont(
                  accountCompletion != 1 ? "Account Setup" : "Congratulations!",
                  18,
                  grey700,
                  1,
                  fontWeight: FontWeight.w600),
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: getCustomFont(
                  accountCompletion != 1
                      ? "Complete your account set-up in three simple steps"
                      : "Your wallet has been created successfully. You can now start making transactions with Tampay!",
                  12.5,
                  grey700,
                  3,
                  fontWeight: FontWeight.normal),
            ),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Row(
                    children: [
                      CircularProgressIndicator(
                        value: accountCompletion,
                        backgroundColor: yellowBg,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          accountCompletion == 1
                              ? successGreen
                              : yellowColor, // Set to green when 100% complete
                        ),
                      ),
                      getHorSpace(FetchPixels.getPixelWidth(10)),
                      getCustomFont(
                          "${(accountCompletion * 100).toInt()}% COMPLETE",
                          15,
                          h6,
                          1,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),

                  // Email Verification
                  customListTile(
                    "Email Verification",
                    14,
                    emailVerified ? grey400Color : grey700,
                    1,
                    trailingImagePath: emailVerified
                        ? "check_circle.svg"
                        : "chevron_right.svg",
                    onTap: emailVerified
                        ? null
                        : () {
                            Constant.sendToNext(
                                context, Routes.verifyEmailRoute);
                          },
                    isCompleted: emailVerified,
                  ),

                  // Phone Number Verification (disabled until email verified)
                  customListTile(
                    "Phone Number",
                    14,
                    phoneNumberVerified ? grey400Color : grey700,
                    1,
                    trailingImagePath: phoneNumberVerified
                        ? "check_circle.svg"
                        : "chevron_right.svg",
                    onTap: (emailVerified && !phoneNumberVerified)
                        ? () {
                            Constant.sendToNext(
                                context, Routes.verifyPhoneNumberRoute);
                          }
                        : null,
                    isCompleted: phoneNumberVerified,
                  ),

                  // Passcode Setup (disabled until phone number verified)
                  customListTile(
                    "Set Passcode",
                    14,
                    passcodeSet ? grey400Color : grey700,
                    1,
                    trailingImagePath:
                        passcodeSet ? "check_circle.svg" : "chevron_right.svg",
                    onTap: (phoneNumberVerified && !passcodeSet)
                        ? () {
                            showDialog(
                              barrierDismissible: true,
                              builder: (context) {
                                return VerifyDialog(
                                  title: "Set Passcode",
                                  imagePath: "lock.svg",
                                  description:
                                      "This passcode will allow access to the app and help keep your Tampay account safe.",
                                  onOk: () {
                                    Navigator.pop(context);
                                    Constant.sendToNext(
                                        context, Routes.setPasscodeRoute);
                                  },
                                  okText: "Set Passcode",
                                );
                              },
                              context: context,
                            );
                          }
                        : null,
                    isCompleted: passcodeSet,
                  ),

                  // Transaction Pin Setup (disabled until passcode set)
                  customListTile(
                    "Set Transaction Pin",
                    14,
                    pinSet ? grey400Color : grey700,
                    1,
                    trailingImagePath:
                        pinSet ? "check_circle.svg" : "chevron_right.svg",
                    onTap: (passcodeSet && !pinSet)
                        ? () {
                            showDialog(
                              barrierDismissible: true,
                              builder: (context) {
                                return VerifyDialog(
                                  title: "Set Transaction Pin",
                                  imagePath: "lock.svg",
                                  description:
                                      "This PIN will help us verify your identity to authorize transactions from your Tampay account.",
                                  onOk: () {
                                    Navigator.pop(context);
                                    Constant.sendToNext(
                                        context, Routes.setTransactionPinRoute);
                                  },
                                  okText: "Create Pin",
                                );
                              },
                              context: context,
                            );
                          }
                        : null,
                    isCompleted: pinSet,
                  ),

                  // BVN Verification (disabled until pin set)
                  customListTile(
                    "Verify Your Identity",
                    14,
                    bvnVerified ? grey400Color : grey700,
                    1,
                    trailingImagePath:
                        bvnVerified ? "check_circle.svg" : "chevron_right.svg",
                    onTap: (pinSet && !bvnVerified)
                        ? () {
                            Constant.sendToNext(
                                context, Routes.verifyIdentityRoute);
                          }
                        : null,
                    isCompleted: bvnVerified,
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
