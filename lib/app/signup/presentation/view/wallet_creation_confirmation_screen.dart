import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/app/view/home/cards/presentation/controller/card_controller.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class WalletCreationConfirmationScreen extends ConsumerWidget {
  const WalletCreationConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCurrency = ref.watch(selectedCurrencyProvider);
    final currencyIcon =
        selectedCurrency == "USD" ? "usd_logo.svg" : "britain_logo.svg";

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
              getSvgImage(currencyIcon, width: 40, height: 40),
              getVerSpace(20),
              getCustomFont(
                "You’re about to create a $selectedCurrency\nWallet",
                22,
                grey700,
                2,
                fontWeight: FontWeight.bold,
              ),
              getVerSpace(30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: grey400,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getCustomFont("DETAILS", 18, grey700, 1,
                        fontWeight: FontWeight.w600, letterSpacing: 1.2),
                    getVerSpace(14),
                    _buildWarningRow("Monthly limit: 5,000"),
                    getVerSpace(10),
                    _buildWarningRow("Creation fee of 5,000 NGN"),
                    getVerSpace(10),
                    _buildWarningRow("Initial deposit of 2"),
                  ],
                ),
              ),
              const Spacer(),
              getButton(
                context,
                primaryColor,
                "👍🏽 Got it!",
                Colors.white,
                () =>  Constant.sendToNext(context, Routes.tierTwoUpgradeRoute),
                16,
                weight: FontWeight.w600,
                buttonHeight: FetchPixels.getPixelHeight(60),
                borderRadius: BorderRadius.circular(15),
              ),
              getVerSpace(20)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningRow(String text) {
    return Row(
      children: [
        getSvgImage("info.svg", width: 20, height: 20),
        const SizedBox(width: 10),
        Expanded(
          child: getCustomFont(text, 14, grey800, 1),
        ),
      ],
    );
  }
}
