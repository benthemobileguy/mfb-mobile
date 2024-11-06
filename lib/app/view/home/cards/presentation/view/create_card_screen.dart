import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/profile/domain/model/response/user_profile.dart';
import 'package:tampay_mobile/app/profile/presentation/controller/profile_controller.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/app/view/dialog/custom_dialog.dart';
import 'package:tampay_mobile/app/view/dialog/verify_dialog.dart';
import 'package:tampay_mobile/app/view/transactions/presentation/controller/transactions_controller.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class CreateCardScreen extends ConsumerStatefulWidget {
  const CreateCardScreen({super.key});

  @override
  ConsumerState<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends ConsumerState<CreateCardScreen> {
  bool isFeeAccepted = false;
  String? selectedCurrency = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context, ""),
              getVerSpace(20),
              getCustomFont("Create New Card", 22, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(10),
              getCustomFont(
                  "Select The Card You’ll Like To Create", 14.5, grey700, 1,
                  fontWeight: FontWeight.w300),
              getVerSpace(20),
              _buildAccountRow("ngn_logo.svg", "Nigerian Naira (NGN)", "NGN"),
              getVerSpace(5),
              _buildAccountRow(
                  "usd_logo.svg", "United States Dollar (USD)", "USD"),
              const Spacer(),
              getButton(
                context,
                isFeeAccepted ? primaryColor : greyColor300,
                "Create Card",
                Colors.white,
                isFeeAccepted && selectedCurrency != null
                    ? () => _handleCreateCard(context)
                    : null,
                16,
                weight: FontWeight.w600,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60),
              ),
              getVerSpace(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountRow(String icon, String name, String currency) {
    bool isSelected = isFeeAccepted && selectedCurrency == currency;

    return InkWell(
      onTap: () {
        setState(() {
          selectedCurrency = currency;
        });
        _showFeeDialog();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            getSvgImage(icon, width: 30, height: 30),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14.5,
                  fontFamily: Constant.fontsFamily,
                  fontWeight: FontWeight.normal,
                  color: grey650,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.orange, size: 20),
          ],
        ),
      ),
    );
  }

  void _showFeeDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "You’ll Be Charged One-time Fees",
          imagePath: "card.svg",
          content: Column(
            children: [
              getVerSpace(FetchPixels.getPixelHeight(20)),
              _buildFeeRow("Card Creation Fee", "\$1"),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              _buildFeeRow("Card Funding", "\$2"),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              Divider(color: greyColor300),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              _buildFeeRow("Total", "\$3", isBold: true),
            ],
          ),
          actions: getButton(
            context,
            primaryColor,
            "OK, Let’s Go Ahead",
            Colors.white,
            () {
              setState(() {
                isFeeAccepted = true;
              });
              Navigator.pop(context);
            },
            16,
            weight: FontWeight.w600,
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)),
            buttonHeight: FetchPixels.getPixelHeight(60),
          ),
        );
      },
    );
  }

  Widget _buildFeeRow(String text, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getCustomFont(text, 14.5, mildGrey, 1, fontWeight: FontWeight.w500),
        getCustomFont(
          amount,
          14,
          mildGrey,
          1,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
        ),
      ],
    );
  }

  Future<void> _handleCreateCard(BuildContext context) async {
    if (selectedCurrency == "USD") {
      // Fetch user profile and check for USD wallet and balance
      final profileController = ref.read(profileControllerProvider);
      final userProfile = profileController.userProfile ?? UserProfile();

      final usdWallet = userProfile.data?.wallets?.firstWhere(
        (wallet) => wallet.currency == "USD" && wallet.isActive == true,
        orElse: () => Wallet(),
      );

      if (usdWallet == null) {
        // Show dialog to create a USD wallet
        showDialog(
          context: context,
          builder: (context) => VerifyDialog(
            title: "Create Dollar Account",
            imagePath: "warning.svg",
            description:
                "Please create a dollar wallet before creating a card, as you currently do not have a dollar account.",
            onOk: () {
              Navigator.pop(context);
              Constant.sendToNext(context, Routes.createWalletRoute);
            },
            okText: "Create Wallet",
          ),
        );
      } else if (double.parse(usdWallet.balance ?? "0") < 3) {
        // Redirect to fund account page if balance is less than $3
        // Show dialog to create a USD wallet
        showDialog(
          context: context,
          builder: (context) => VerifyDialog(
            title: "Fund Dollar Account",
            imagePath: "warning.svg",
            description:
                "Your amount is not sufficient. Please fund up to 3 dollars to be able to create a card.",
            onOk: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.convertRoute);
            },
            okText: "Fund Wallet",
          ),
        );
      } else {
        // If balance is sufficient, create the card
        await ref
            .read(transactionsControllerProvider)
            .createCard(context, selectedCurrency!);
      }
    } else {
      // Handle NGN card creation
      await ref
          .read(transactionsControllerProvider)
          .createCard(context, selectedCurrency!);
    }
  }
}
