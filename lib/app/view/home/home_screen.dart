import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../theme/color_data.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var horspace = FetchPixels.getPixelHeight(20);
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerSpace(FetchPixels.getPixelHeight(10)),
              appBar(context),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              accountCompletionStatus(context),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              currencyToggle(context),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              balanceForUser(context),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              addConvertMoneyRow(context),
              getVerSpace(FetchPixels.getPixelHeight(40)),
              recentTransactions(context),
              getVerSpace(FetchPixels.getPixelHeight(40)),
              referFriends(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getCustomFont("Good Day Jeffrey", 16, h6, 1,
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

  accountCompletionStatus(BuildContext context) {
    return InkWell(
      onTap: () {
        Constant.sendToNext(context, Routes.accountSetUpRoute);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: yellowBg.withOpacity(0.3),
            border: Border.all(color: yellowBg, width: 2)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont("40% COMPLETE", 15, h6, 1,
                    fontWeight: FontWeight.w600, letterSpacing: 1.5),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getCustomFont("Complete Account Setup", 14, h6, 1,
                    fontWeight: FontWeight.w500),
                getVerSpace(FetchPixels.getPixelHeight(5)),
                getCustomFont(
                    "Unlock all features by completing your profile", 14, h6, 1,
                    fontWeight: FontWeight.w400),
              ],
            ),
            getSvgImage("chevron_right.svg", width: 16, height: 16)
          ],
        ),
      ),
    );
  }

  currencyToggle(BuildContext context) {
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
                _showAccountDetails(context);
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

  balanceForUser(BuildContext context) {
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
                child: getCustomFont("₦", 20, Colors.black, 1,
                    fontWeight: FontWeight.w500, letterSpacing: 1.5),
              ),
              getCustomFont("0", 34, Colors.black, 1,
                  fontWeight: FontWeight.w500, letterSpacing: 1.5),
              TextButton(
                  onPressed: () {},
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

  addConvertMoneyRow(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      Row(
        children: [
          Expanded(
            child: getButton(context, blue, "Add Money", Colors.white, () {
              Constant.sendToNext(context, Routes.addMoneyRoute);
            }, 16,
                weight: FontWeight.w600,
                image: "add_money_icon.svg",
                isIcon: true,
                borderRadius: BorderRadius.circular(30),
                buttonHeight: 60),
          ),
          getHorSpace(12),
          Expanded(
            child: getButton(context, lightBlue, "Convert", blue, () {
              Constant.sendToNext(context, Routes.convertRoute);
            }, 16,
                image: "convert_money_icon.svg",
                isIcon: true,
                weight: FontWeight.w600,
                borderRadius: BorderRadius.circular(30),
                buttonHeight: 60),
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
          getCustomFont("Recent Transactions", 16, grey600, 1,
              fontWeight: FontWeight.w600),
          getVerSpace(30),
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
          image: AssetImage(
              'assets/images/gradient_refer_bg.png'), // Ensure the image is in your assets folder
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),

      /// TODO: Use real values here
    );
  }

  void _showAccountDetails(BuildContext context) {
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
                  "ACCOUNT HOLDER", "Mamudu Jefferey", false),
              getVerSpace(12),
              accountDetailComponent("ACCOUNT NUMBER", "121233211", true),
              getVerSpace(12),
              accountDetailComponent("ROUTING", "232120910290101", true),
              getVerSpace(12),
              accountDetailComponent("ADDRESS",
                  "383 Madison Avenue in Midtown Manhattan, USA", true),
              getVerSpace(30),
            ],
          ),
        );
      },
    );
  }

  accountDetailComponent(String title, String result, bool showCopy) {
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
                getCustomFont(result, 16, h6, 1)
              ],
            ),
          ),
          const Spacer(),
          if (showCopy)
            getSvgImage("copy.svg", height: 30, width: 30, color: h6)
        ],
      ),
    );
  }
}
