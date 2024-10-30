import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/main.dart';
import 'package:tampay_mobile/manager/auth_manager.dart';
import 'package:tampay_mobile/theme/color_data.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../profile/presentation/controller/profile_controller.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileControllerProvider);
    final userProfile = profileController.userProfile;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getCustomFont("Profile", 18, grey700, 1,
                    fontWeight: FontWeight.w600),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelWidth(20),
                      vertical: FetchPixels.getPixelHeight(20)),
                  decoration: BoxDecoration(
                      color: grey600,
                      border: Border.all(color: teal),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    children: [
                      profileImageWidget(),
                      getHorSpace(FetchPixels.getPixelWidth(20)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont(
                              '${userProfile?.data?.firstName} ${userProfile?.data?.lastName}',
                              14,
                              grey700,
                              1),
                          getVerSpace(10),
                          getCustomFont(
                              "View Account Details", 12.5, grey700, 1),
                        ],
                      ),
                    ],
                  ),
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                customLeadingListTile("Account Security", 15, h6, 1,
                    trailingImagePath: "chevron_right.svg",
                    leadingImagePath: "account_security.svg",
                    subtitle: "Protect yourself from intruders",
                    fontWeight: FontWeight.w500, onTap: () {
                  Constant.sendToNext(context, Routes.accountSecurityRoute);
                }),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                customLeadingListTile("Statements And Reports", 15, h6, 1,
                    trailingImagePath: "chevron_right.svg",
                    leadingImagePath: "statements.svg",
                    subtitle: "Monitor account activity",
                    fontWeight: FontWeight.w500, onTap: () {
                  Constant.sendToNext(context, Routes.statementReportsRoute);
                }),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                customLeadingListTile("Beneficiaries", 15, h6, 1,
                    trailingImagePath: "chevron_right.svg",
                    leadingImagePath: "beneficiaries.svg",
                    subtitle: "Your Tampay friends",
                    fontWeight: FontWeight.w500, onTap: () {
                  Constant.sendToNext(
                      context, Routes.profileBeneficiariesRoute);
                }),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                customLeadingListTile("Support", 15, h6, 1,
                    trailingImagePath: "chevron_right.svg",
                    subtitle: "Get in touch with us",
                    leadingImagePath: "support.svg",
                    fontWeight: FontWeight.w500, onTap: () {
                  Constant.sendToNext(context, Routes.supportRoute);
                }),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                customLeadingListTile("Referrals", 15, h6, 1,
                    trailingImagePath: "chevron_right.svg",
                    subtitle: "Invite your friends and earn extra",
                    leadingImagePath: "referrals.svg",
                    fontWeight: FontWeight.w500, onTap: () {
                  Constant.sendToNext(context, Routes.referralsRoute);
                }),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                customLeadingListTile("Legal", 15, h6, 1,
                    subtitle: "About our contract with you",
                    trailingImagePath: "chevron_right.svg",
                    leadingImagePath: "legal.svg",
                    fontWeight: FontWeight.w500, onTap: () {
                  Constant.sendToNext(context, Routes.legalRoute);
                }),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Center(
                  child: getButton(
                    context,
                    grey100,
                    "Log out",
                    grey700,
                    () {
                      logOut();
                    },
                    16,
                    weight: FontWeight.normal,
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(20)),
                    buttonHeight: FetchPixels.getPixelHeight(45),
                    buttonWidth: FetchPixels.getPixelWidth(140),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logOut() async {
    getIt<AuthManager>().clearAuthDetails();
    Constant.sendToNext(context, Routes.loginRoute);
  }
}
