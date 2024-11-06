import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tampay_mobile/app/profile/domain/model/response/user_profile.dart';
import 'package:tampay_mobile/app/profile/presentation/controller/profile_controller.dart';
import 'package:tampay_mobile/app/view/dialog/verify_dialog.dart';
import 'package:tampay_mobile/app/view/home/send/recent_transactions.dart';
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
  String selectedCurrency = "NGN";

  // Currency logo and symbol mapping
  final Map<String, String> currencyLogos = {
    "EUR": "euro_flag.svg",
    "NGN": "ngn_logo.svg",
    "USD": "usd_logo.svg",
    "GBP": "britain_logo.svg",
  };

  final Map<String, String> currencySymbols = {
    "EUR": "€",
    "NGN": "NGN",
    "USD": "\$",
    "GBP": "£",
  };

  // Currency sign mapping for balance display
  final Map<String, String> currencySigns = {
    "EUR": "euro_sign.svg",
    "NGN": "naira_sign.svg",
    "USD": "dollar_sign.svg",
    "GBP": "pounds_sign.svg",
  };

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    final profileController = ref.watch(profileControllerProvider);
    final userProfile = profileController.userProfile ?? UserProfile();
    bool accountSetupComplete =
        profileController.isAccountSetupComplete(userProfile);
    final bool isWalletNotCreated = userProfile.data?.wallets?.isEmpty ?? false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: RefreshIndicator(
            color: primaryColor,
            onRefresh: _refreshProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  appBar(context, userProfile),
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  if (!accountSetupComplete || isWalletNotCreated)
                    accountCompletionStatus(context, userProfile,
                        accountSetupComplete, !isWalletNotCreated),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        currencyToggle(context, accountSetupComplete,
                            userProfile, selectedCurrency),
                        getVerSpace(FetchPixels.getPixelHeight(30)),
                        balanceForUser(context, userProfile),
                        getVerSpace(FetchPixels.getPixelHeight(30)),
                        addConvertMoneyRow(
                            context, accountSetupComplete, userProfile),
                        getVerSpace(FetchPixels.getPixelHeight(30)),
                      ],
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const RecentTransactions(),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  referFriends(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context, UserProfile userProfile) {
    return getPaddingWidget(
      const EdgeInsets.symmetric(horizontal: 10),
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
                width: FetchPixels.getPixelHeight(40),
                height: FetchPixels.getPixelHeight(40)),
          )
        ],
      ),
    );
  }

  Widget accountCompletionStatus(BuildContext context, UserProfile userProfile,
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

  Widget currencyToggle(BuildContext context, bool accountSetupComplete,
      UserProfile userProfile, String selectedCurrency) {
    return Container(
      child: getPaddingWidget(
        EdgeInsets.symmetric(horizontal: horspace),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: grayColor,
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
              child: Row(
                children: [
                  getSvgImage(currencyLogos[selectedCurrency] ?? "ngn_logo.svg",
                      width: 24, height: 24),
                  getHorSpace(10),
                  GestureDetector(
                    onTap: () => _showCurrencySelectionSheet(context),
                    child: Row(
                      children: [
                        getCustomFont(
                            _getCurrencyName(selectedCurrency), 16, grey650, 1,
                            fontWeight: FontWeight.w600),
                        getHorSpace(10),
                        getSvgImage("chevron_down.svg", width: 16, height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  if (!accountSetupComplete) {
                    showCompleteAccountSetupDialog(context);
                  } else {
                    _showAccountDetails(context, userProfile, selectedCurrency);
                  }
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: getSvgImage("context_menu_icon.svg",
                    width: 28, height: 28)),
          ],
        ),
      ),
    );
  }

  String _getCurrencyName(String currencyCode) {
    switch (currencyCode) {
      case "EUR":
        return "Euro";
      case "NGN":
        return "Nigerian Naira";
      case "USD":
        return "US Dollar";
      case "GBP":
        return "British Pound";
      default:
        return "Currency";
    }
  }

  void _showCurrencySelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            getCustomFont("Select Currency", 16.5, grey700, 1,
                fontWeight: FontWeight.bold),
            ...currencyLogos.keys.map((currency) {
              return ListTile(
                leading: getSvgImage(currencyLogos[currency] ?? "usd_logo.svg",
                    width: 30, height: 30),
                title: getCustomFont(_getCurrencyName(currency), 16, grey700, 1,
                    fontWeight: FontWeight.bold),
                onTap: () {
                  setState(() {
                    selectedCurrency = currency;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        );
      },
    );
  }

  Widget balanceForUser(BuildContext context, UserProfile? userProfile) {
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
                      _isBalanceVisible = !_isBalanceVisible;
                    });
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(0, 0)),
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
                      ))),
            ],
          ),
        ],
      ),
    );
  }

  Widget addConvertMoneyRow(BuildContext context, bool accountSetupComplete,
      UserProfile userProfile) {
    final bool isTier2Account = userProfile.data?.kycLevel == "Tier 2";
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      Row(
        children: [
          Expanded(
            child: getButton(context, blue, "Add Money", Colors.white, () {
              if (!accountSetupComplete) {
                showCompleteAccountSetupDialog(context);
              } else if (!isTier2Account && selectedCurrency != "NGN") {
                // Navigate to Tier 2 screen only if user is not a Tier 2 account and currency is not NGN
                Constant.sendToNext(context, Routes.tierTwoUpgradeRoute);
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
              } else if (!isTier2Account && selectedCurrency != "NGN") {
                // Navigate to Tier 2 screen only if user is not a Tier 2 account and currency is not NGN
                Constant.sendToNext(context, Routes.tierTwoUpgradeRoute);
              } else {
                Constant.sendToNext(context, Routes.convertRoute);
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

  Widget referFriends(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 109,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/gradient_refer_bg.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Center(
        child:
            getCustomFont("", 18, Colors.white, 1, fontWeight: FontWeight.w600),
      ),
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
                  "ACCOUNT NAME",
                  userProfile.data?.wallets?[0].accountName ?? "",
                  false,
                  context),
              getVerSpace(10),
              accountDetailComponent("BANK NAME",
                  userProfile.data?.wallets?[0].bankName ?? "", false, context),
              getVerSpace(16),
              getButton(
                  context, primaryColor, "Share all Details", Colors.white, () {
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

  Widget accountDetailComponent(
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

  void _shareAccountDetails(UserProfile userProfile) {
    String accountDetails = """
    Bank: ${userProfile.data?.wallets?[0].accountName ?? "N/A"}
    Account Number: ${userProfile.data?.wallets?[0].accountNumber ?? "N/A"}
    Currency: ${userProfile.data?.wallets?[0].currency ?? "N/A"}
    """;

    Share.share(accountDetails, subject: 'Tampay Account Details');
  }

  Future<dynamic> showCompleteAccountSetupDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: true,
      builder: (context) {
        return VerifyDialog(
          title: "Complete Account Setup",
          imagePath: "warning.svg",
          description:
              "To access this feature, please complete your account setup.",
          onOk: () {
            Navigator.pop(context);
            Constant.sendToNext(context, Routes.accountSetUpRoute);
          },
          okText: "Complete Account Setup",
        );
      },
      context: context,
    );
  }

  void _showAccountDetails(
      BuildContext context, UserProfile userProfile, String selectedCurrency) {
    final bool isTier2Account = userProfile.data?.kycLevel == "Tier 2";

    // Check if the user is not Tier 2 and the selected currency is not NGN
    if (!isTier2Account && selectedCurrency != "NGN") {
      // Navigate to the Tier 2 upgrade screen
      Constant.sendToNext(context, Routes.tierTwoUpgradeRoute);
      return; // Exit the method early to avoid showing the bottom sheet
    }

    // Show account details if conditions are met
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
                  "ACCOUNT NUMBER",
                  userProfile.data?.wallets?[0].accountNumber ?? "",
                  true,
                  context),
              getVerSpace(10),
              accountDetailComponent(
                  "ACCOUNT NAME",
                  userProfile.data?.wallets?[0].accountName ?? "",
                  false,
                  context),
              getVerSpace(10),
              accountDetailComponent("BANK NAME",
                  userProfile.data?.wallets?[0].bankName ?? "", false, context),
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
}
