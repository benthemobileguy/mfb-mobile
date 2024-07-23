import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

import '../../../../../base/constant.dart';
import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../routes/app_routes.dart';

class SendWithTampayTag extends StatefulWidget {
  const SendWithTampayTag({super.key});

  @override
  State<SendWithTampayTag> createState() => _SendWithTampayTagState();
}

class _SendWithTampayTagState extends State<SendWithTampayTag> {
  TextEditingController recipientTagController = TextEditingController();
  TextEditingController narrationController = TextEditingController();
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
                Row(
                  children: [
                    backButtonWidget("back.svg", context: context),
                    const Spacer(),
                    Center(
                      child: getCustomFont("Send Via Tampay Tag", 15, h6, 1,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    getHorSpace(55)
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                accountBalance(context),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                amountInput(context),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getDefaultTextFiledWithLabel(
                  context,
                  "Recipient's Tag",
                  title: "Enter recipient’s Tampay tag ",
                  recipientTagController,
                  height: FetchPixels.getPixelHeight(60),
                  isEnable: false,
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getDefaultTextFiledWithLabel(
                  context,
                  "Describe transaction",
                  title: "Narration (optional)",
                  recipientTagController,
                  height: FetchPixels.getPixelHeight(60),
                  isEnable: false,
                ),
                const Spacer(),
                getButton(context, primaryColor, "Send", Colors.white, () {
                  Constant.sendToNext(
                      context, Routes.sendMoneyConfirmationRoute);
                }, 16,
                    weight: FontWeight.w600,
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                    buttonHeight: FetchPixels.getPixelHeight(60)),
                getVerSpace(FetchPixels.getPixelHeight(30)),
              ],
            ),
          ),
        ));
  }
}
