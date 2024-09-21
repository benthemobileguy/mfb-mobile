import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tampay_mobile/app/profile/domain/model/response/user_profile.dart';
import 'package:tampay_mobile/app/profile/presentation/controller/profile_controller.dart';
import '../../../base/constant.dart';
import 'package:flutter/services.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../theme/color_data.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var horspace = FetchPixels.getPixelHeight(20);
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    final profileController = ref.watch(profileControllerProvider);
    final userProfile = profileController.userProfile ?? UserProfile();
    bool accountSetupComplete =
        profileController.isAccountSetupComplete(userProfile);
    final bool isWalletNotCreated = userProfile.data?.wallets?.isEmpty ?? false;

    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: RefreshIndicator(
            color: primaryColor,
            onRefresh: _refreshProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  appBar(context, userProfile),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  if (!accountSetupComplete || isWalletNotCreated)
                    accountCompletionStatus(context, userProfile,
                        accountSetupComplete, !isWalletNotCreated),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  currencyToggle(context, accountSetupComplete, userProfile),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  balanceForUser(context, userProfile),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  addConvertMoneyRow(
                      context, accountSetupComplete, userProfile),
                  getVerSpace(FetchPixels.getPixelHeight(40)),
                  recentTransactions(context),
                  getVerSpace(FetchPixels.getPixelHeight(40)),
                  referFriends(context)
                ],
              ),
            ),
          )),
    );
  }

  Widget appBar(BuildContext context, UserProfile userProfile) {
    return getPaddingWidget(
      const EdgeInsets.symmetric(horizontal: 0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getCustomFont(
                  "Good Day ${userProfile.data?.firstName}☀️", 16, h6, 1,
                  fontWeight: FontWeight.w600),
            ],
          ),
          GestureDetector(
            onTap: () {
              Constant.sendToNext(context, Routes.profileRoute);
            },
            child: getSvgImage("profile_circle.svg",
                width: FetchPixels.getPixelHeight(32),
                height: FetchPixels.getPixelHeight(32)),
          )
        ],
      ),
    );
  }

  accountCompletionStatus(BuildContext context, UserProfile userProfile,
      bool isAccountSetUpComplete, bool isWalletCreated) {
    bool accountInReview = isAccountSetUpComplete && !isWalletCreated;
    return InkWell(
      onTap: () {
        Constant.sendToNext(context, Routes.accountSetUpRoute);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:
                accountInReview ? successLightColor : yellowBg.withOpacity(0.3),
            border: Border.all(
                color: accountInReview ? successGreen : yellowBg, width: 2)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(
                    "${userProfile.data?.accountCompletionStatus.toString()}% COMPLETE",
                    15,
                    h6,
                    1,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getCustomFont(
                    isWalletCreated
                        ? "Account in Review"
                        : "Complete Account Setup",
                    14,
                    h6,
                    1,
                    fontWeight: FontWeight.w500),
                getVerSpace(FetchPixels.getPixelHeight(5)),
                getCustomFont(
                    isWalletCreated
                        ? "Features would be unlocked after verification"
                        : "Unlock all features by completing your profile",
                    14,
                    h6,
                    2,
                    fontWeight: FontWeight.w400),
              ],
            ),
            getSvgImage("chevron_right.svg", width: 16, height: 16)
          ],
        ),
      ),
    );
  }

  currencyToggle(BuildContext context, bool accountSetupComplete,
      UserProfile userProfile) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      Row(
        children: [
          getSvgImage("ngn_logo.svg", width: 24, height: 24),
          getHorSpace(10),
          getCustomFont("Nigerian Naira", 16, grey650, 1,
              fontWeight: FontWeight.w600),
          getHorSpace(10),
          getSvgImage("chevron_down.svg", width: 16, height: 16),
          const Spacer(),
          TextButton(
              onPressed: () {
                if (!accountSetupComplete) {
                  showCompleteAccountSetupDialog(context);
                } else {
                  _showAccountDetails(context, userProfile);
                }
              },
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child:
                  getSvgImage("context_menu_icon.svg", width: 28, height: 28)),
        ],
      ),
    );
  }

  balanceForUser(BuildContext context, UserProfile? userProfile) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCustomFont("BALANCE", 15, h6, 1,
              fontWeight: FontWeight.w600, letterSpacing: 1.5),
          getVerSpace(5),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: getSvgImage("naira_sign.svg"),
              ),
              SizedBox(
                width: 170,
                child: getCustomFont(
                  _isBalanceVisible &&
                          (userProfile?.data?.wallets?.isNotEmpty ?? false)
                      ? userProfile!.data!.wallets![0].balance ?? "----"
                      : "----",
                  34,
                  Colors.black,
                  1,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                ),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _isBalanceVisible =
                          !_isBalanceVisible; // Toggle visibility
                    });
                  },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: grey400Color,
                        ),
                      ),
                      child: Icon(
                        Icons.visibility_off,
                        color: grey400Color,
                        size: 16,
                      )))
            ],
          ),
        ],
      ),
    );
  }

  addConvertMoneyRow(BuildContext context, bool accountSetupComplete,
      UserProfile userProfile) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      Row(
        children: [
          Expanded(
            child: getButton(context, blue, "Add Money", Colors.white, () {
              if (!accountSetupComplete) {
                showCompleteAccountSetupDialog(context);
              } else {
                showAddMoneyBottomSheet(context, userProfile);
              }
            }, 16,
                weight: FontWeight.w600,
                image: "add_money_icon.svg",
                isIcon: true,
                borderRadius: BorderRadius.circular(30),
                buttonHeight: 53),
          ),
          getHorSpace(12),
          Expanded(
            child: getButton(context, lightBlue, "Convert", blue, () {
              if (!accountSetupComplete) {
                showCompleteAccountSetupDialog(context);
              } else {
                Constant.sendToNext(context, Routes.addMoneyRoute);
              }
            }, 16,
                image: "convert_money_icon.svg",
                isIcon: true,
                weight: FontWeight.w600,
                borderRadius: BorderRadius.circular(30),
                buttonHeight: 53),
          ),
        ],
      ),
    );
  }

  recentTransactions(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCustomFont("Recent Transactions", 16, grey650, 1,
              fontWeight: FontWeight.w600),
          getVerSpace(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getSvgImage("clock.svg", width: 16, height: 16),
              getHorSpace(10),
              getCustomFont("No Transactions yet", 15, grey400Color, 1,
                  fontWeight: FontWeight.normal),
            ],
          ),
        ],
      ),
    );
  }

  referFriends(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 173,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/gradient_refer_bg.png'),
          // Ensure the image is in your assets folder
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),

      /// TODO: Use real values here
    );
  }

  void _showAccountDetails(BuildContext context, UserProfile userProfile) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dragIndicator(context),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Account Details",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: grey700,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              getVerSpace(25),
              accountDetailComponent(
                  "ACCOUNT HOLDER",
                  userProfile.data?.wallets?[0].accountName ?? "",
                  false,
                  context),
              getVerSpace(12),
              accountDetailComponent(
                  "ACCOUNT NUMBER",
                  userProfile.data?.wallets?[0].accountNumber ?? "",
                  true,
                  context),
              getVerSpace(12),
              if (userProfile.data?.wallets?[0].currency != "NGN")
                accountDetailComponent(
                    "ROUTING", "232120910290101", true, context),
              getVerSpace(12),
              if (userProfile.data?.wallets?[0].currency != "NGN")
                accountDetailComponent(
                    "ADDRESS",
                    "383 Madison Avenue in Midtown Manhattan, USA",
                    true,
                    context),
              if (userProfile.data?.wallets?[0].currency != "NGN")
                getVerSpace(30),
            ],
          ),
        );
      },
    );
  }

  Future<void> _refreshProfile() async {
    await ref.read(profileControllerProvider).getProfile();
  }

  Future<dynamic> showAddMoneyBottomSheet(
      BuildContext context, UserProfile userProfile) {
    return showModalBottomSheet(
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Money",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: grey700,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
                maxLines: null,
              ),
              getVerSpace(8),
              getCustomFont(
                  "Top up your Tampay Naira account with the\ndetails below:",
                  12,
                  greyColor,
                  2),
              getVerSpace(16),
              accountDetailComponent(
                  "ACCOUNT NUMBER",
                  userProfile.data?.wallets?[0].accountNumber ?? "",
                  true,
                  context),
              getVerSpace(10),
              accountDetailComponent(
                  "BANK",
                  userProfile.data?.wallets?[0].accountName ?? "",
                  false,
                  context),
              getVerSpace(16),
              getButton(
                  context, primaryColor, "Share all Details", Colors.white, () {
                // should be able to share account details
                _shareAccountDetails(userProfile);
              }, 16,
                  weight: FontWeight.w600,
                  image: "share_white.svg",
                  isIcon: true,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                  buttonHeight: FetchPixels.getPixelHeight(60)),
              getVerSpace(16),
            ],
          ),
        );
      },
      context: context,
    );
  }

  accountDetailComponent(
      String title, String result, bool showCopy, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: grey100,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.bold,
                    color: greyColor,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  maxLines: null,
                ),
                getVerSpace(8),
                getCustomFont(result, 16, grey800, 1)
              ],
            ),
          ),
          if (showCopy)
            GestureDetector(
              onTap: () {
                Clipboard.setData(
                    ClipboardData(text: result)); // Copy to clipboard
                showToast(context, "Copied to clipboard!");
              },
              child: getSvgImage("copy.svg", height: 30, width: 30, color: h6),
            ),
        ],
      ),
    );
  }

// Method to concatenate account details and trigger share
  void _shareAccountDetails(UserProfile userProfile) {
    // Create a formatted string with the account details
    String accountDetails = """
  Bank: ${userProfile.data?.wallets?[0].accountName ?? "N/A"}
  Account Number: ${userProfile.data?.wallets?[0].accountNumber ?? "N/A"}
  Currency: ${userProfile.data?.wallets?[0].currency ?? "N/A"}
  """;

    // Use the share_plus package to share the details
    Share.share(accountDetails, subject: 'Tampay Account Details');
  }
}
