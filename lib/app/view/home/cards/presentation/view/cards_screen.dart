import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/app/view/home/send/recent_transactions.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  TextEditingController amountController = TextEditingController();
  bool hasCards = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              child: getCustomFont("Cards", 24, Colors.black, 1,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: hasCards ? _buildCardList(context) : _buildEmptyState(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Row(
              children: [
                getPngImage("usd_logo.png", width: 30, height: 30),
                getHorSpace(FetchPixels.getPixelWidth(10)),
                getCustomFont("United States Dollar", 14, grey650, 1,
                    fontWeight: FontWeight.w500),
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: grey100, borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: getCustomFont("Master Card", 14, grey650, 1,
                      fontWeight: FontWeight.w500),
                ),
                getHorSpace(FetchPixels.getPixelWidth(5)),
                Container(
                  decoration: BoxDecoration(
                      color: grey100, borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: getCustomFont("Balance: \$500.43", 14, grey650, 1,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: grey600.withOpacity(0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconWithText('card_add.svg', 'Add money', () {
                    // Add money functionality
                  }),
                  _buildIconWithText('freeze_card.svg', 'Freeze', () {
                    // Freeze card functionality
                  }),
                  _buildIconWithText('details_card.svg', 'Details', () {
                    // Card details functionality
                  }),
                  _buildIconWithText('more_details.svg', 'More', () {
                    showToast(context, "Coming soon");
                  }),
                ],
              ),
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            const RecentTransactions(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getSvgImage("credit_card.svg", width: 180, height: 127),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          getCustomFont("Create a Tampay Card", 18.5, Colors.black, 1,
              fontWeight: FontWeight.w500),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          TextButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              minimumSize: WidgetStateProperty.all(Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
            Constant.sendToNext(context, Routes.createCardRoute);
            },
            child: getCustomFont("Create card", 16.5, primaryColor, 1,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithText(String svgAsset, String label, Function() onTap) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onTap,
      child: Column(
        children: [
          getSvgImage(svgAsset, width: 40, height: 40),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          getCustomFont(label, 14, grey700, 1, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}
