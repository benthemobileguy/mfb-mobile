import 'package:flutter/material.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

import '../../../base/constant.dart';

class ProfileBeneficiariesScreen extends StatefulWidget {
  const ProfileBeneficiariesScreen({super.key});

  @override
  State<ProfileBeneficiariesScreen> createState() =>
      _ProfileBeneficiariesScreenState();
}

class _ProfileBeneficiariesScreenState
    extends State<ProfileBeneficiariesScreen> {
  SearchController searchController = SearchController();
  void finishView() {
    Constant.closeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButtonWidget("back.svg", context: context),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getCustomFont("Beneficiaries", 18, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: grey400Color, width: 1),
                ),
                child: TextField(
                  enabled: true,
                  onTap: () {},
                  autofocus: false,
                  onChanged: (value) {},
                  textInputAction: TextInputAction.search,
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: grey400Color),
                    hintText: "Search Beneficiaries",
                    hintStyle: TextStyle(
                        color: grey400Color,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: Constant.fontsFamily),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: Constant.fontsFamily),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              Expanded(
                child: ListView(
                  children: [
                    _buildBeneficiaryItem("BJ", "Ben Johnson"),
                    _buildBeneficiaryItem("AL", "Alice Lawrence"),
                    _buildBeneficiaryItem("JW", "John Williams"),
                    _buildBeneficiaryItem("RM", "Rachel Moore"),
                    _buildBeneficiaryItem("SP", "Sam Peters"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBeneficiaryItem(String initials, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          // Handle beneficiary item tap
        },
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: getCustomFont(
                  initials,
                  18,
                  Colors.white,
                  1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            getHorSpace(FetchPixels.getPixelWidth(20)),
            Expanded(
              child: getCustomFont(
                title,
                14.5,
                h6,
                1,
                fontWeight: FontWeight.w500,
              ),
            ),
            getSvgImage("chevron_right.svg",
                color: greyColor, width: 18, height: 18)
          ],
        ),
      ),
    );
  }
}
