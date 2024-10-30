import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/app/view/home/cards/presentation/controller/card_controller.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class CreateWalletScreen extends ConsumerWidget {
  const CreateWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFeeAccepted = ref.watch(isFeeAcceptedProvider);
    final selectedCurrency = ref.watch(selectedCurrencyProvider);

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
              getCustomFont("Create New Wallet", 22, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(10),
              getCustomFont("Select Account To Create", 14.5, grey700, 1,
                  fontWeight: FontWeight.w300),
              getVerSpace(20),
              _buildAccountRow(
                context,
                ref,
                icon: "britain_logo.svg",
                name: "Great British Pound (GBP)",
                currency: "GBP",
              ),
              getVerSpace(5),
              _buildAccountRow(
                context,
                ref,
                icon: "usd_logo.svg",
                name: "United States Dollar (USD)",
                currency: "USD",
              ),
              const Spacer(),
              getButton(
                context,
                isFeeAccepted ? primaryColor : greyColor300,
                "Create Wallet",
                Colors.white,
                isFeeAccepted && selectedCurrency != null
                    ? () => _handleCreateWallet(context)
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

  Widget _buildAccountRow(
    BuildContext context,
    WidgetRef ref, {
    required String icon,
    required String name,
    required String currency,
  }) {
    final isSelected = ref.watch(selectedCurrencyProvider) == currency;

    return InkWell(
      onTap: () {
        // Update both selected currency and fee acceptance status
        ref.read(selectedCurrencyProvider.notifier).state = currency;
        ref.read(isFeeAcceptedProvider.notifier).state = true;
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

  Future<void> _handleCreateWallet(BuildContext context) async {
    Constant.sendToNext(context, Routes.createWalletConfirmationRoute);
  }

  Widget _buildFeeRow(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: grey700,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: grey700,
          ),
        ),
      ],
    );
  }
}
