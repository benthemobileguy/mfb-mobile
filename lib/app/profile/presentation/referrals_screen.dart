import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class ReferralsScreen extends StatefulWidget {
  const ReferralsScreen({super.key});

  @override
  State<ReferralsScreen> createState() => _ReferralsScreenState();
}

class _ReferralsScreenState extends State<ReferralsScreen> {
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
                getCustomFont("Referrals", 18, grey700, 1,
                    fontWeight: FontWeight.w600),
                getVerSpace(FetchPixels.getPixelHeight(5)),
                getCustomFont(
                    "Invite your friends and earn extra", 14.5, greyColor, 1,
                    fontWeight: FontWeight.normal),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getPngImage("referral_badge.png"),
                getVerSpace(FetchPixels.getPixelHeight(40)),
                GestureDetector(
                  onTap: () {
                    showToast(context, "Coming soon");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: grey100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18))),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getCustomFont(
                                "REFERRAL LINK",
                                13.5,
                                letterSpacing: 1.1,
                                greyColor,
                                1),
                            getVerSpace(10),
                            Row(
                              children: [
                                getCustomFont(
                                    "@mamudue",
                                    14.5,
                                    letterSpacing: 1.1,
                                    h6,
                                    1,
                                    fontWeight: FontWeight.w500),
                                const SizedBox(width: 10),
                                InkWell(
                                    onTap: () {
                                      Clipboard.setData(
                                          const ClipboardData(text: ""));
                                      showToast(context, "Copied to clipboard");
                                    },
                                    child: getSvgImage("copy.svg")),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        getCustomFont("Share", 14.5, greyColor, 1),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
