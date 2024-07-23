import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tampay_mobile/theme/color_data.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
                      color: grayColor,
                      border: Border.all(
                        color: teal
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    children: [
                      profileImageWidget(),
                      getHorSpace(FetchPixels.getPixelWidth(20)),
                      getCustomFont("Mamudu Jeffrey", 14, grey700, 1),
                      const Spacer(),
                      getCustomFont("View Profile", 14, grey700, 1),
                    ],
                  ),
                ),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                customLeadingListTile("Bank Transfer", 15, h6, 1,
                    trailingImagePath: "chevron_right.svg",
                    leadingImagePath: "bank_transfer.svg",
                    fontWeight: FontWeight.w500,
                    onTap: () {}),
                getVerSpace(FetchPixels.getPixelHeight(15)),
                customLeadingListTile("Send Via Tampay Tag", 15, h6, 1,
                    trailingImagePath: "chevron_right.svg",
                    leadingImagePath: "send_tampay.svg",
                    fontWeight: FontWeight.w500,
                    onTap: () {}),
                getVerSpace(FetchPixels.getPixelHeight(15)),
                customLeadingListTile("Pay Bills", 15, h6, 1,
                    trailingImagePath: "chevron_right.svg",
                    leadingImagePath: "pay_bills.svg",
                    fontWeight: FontWeight.w500,
                    onTap: () {}),
                getVerSpace(FetchPixels.getPixelHeight(15)),
                customLeadingListTile("Offline Transfers", 15, h6, 1,
                    trailingImagePath: "chevron_right.svg",
                    leadingImagePath: "offline_transfers.svg",
                    fontWeight: FontWeight.w500,
                    onTap: () {}),
                getVerSpace(FetchPixels.getPixelHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
