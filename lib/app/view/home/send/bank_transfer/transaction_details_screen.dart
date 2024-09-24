import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';

import '../../../../../base/widget_utils.dart';
import '../../../../../theme/color_data.dart';
import '../../../transactions/presentation/controller/transactions_controller.dart';

class TransactionDetailsScreen extends ConsumerStatefulWidget {
  const TransactionDetailsScreen({super.key});

  @override
  ConsumerState<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState
    extends ConsumerState<TransactionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final transactionsController = ref.read(transactionsControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    backButtonWidget("back.svg", context: context),
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                transactionDetails(context),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: grey600,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getCustomFont("OUTWARD TRANSFER", 12, greyColor, 1,
                          letterSpacing: 1.4),
                      getVerSpace(6),
                      getCustomFont("-₦30,490", 34, redColor2, 1,
                          fontWeight: FontWeight.w500),
                      getVerSpace(6),
                      getCustomFont(
                          "on June 19th , 2024 at 12:34pm", 12.5, grey650, 1),
                    ],
                  ),
                ),
                getVerSpace(16),
                getCustomFont("BENEFICIARY", 12, greyColor, 1,
                    letterSpacing: 1.4),
                getVerSpace(6),
                getCustomFont("Tunde Ayomide", 16.5, h6, 1, letterSpacing: 1.4),
                getVerSpace(20),
                getCustomFont("NARRATION", 12, greyColor, 1,
                    letterSpacing: 1.4),
                getVerSpace(6),
                getCustomFont("Weekend Steeze 💪🏿 ", 16.5, h6, 1,
                    letterSpacing: 1.4),
                getVerSpace(20),
                getCustomFont("BANK", 12, greyColor, 1, letterSpacing: 1.4),
                getVerSpace(6),
                Row(
                  children: [
                    getPngImage("kuda.png", height: 30, width: 30),
                    getHorSpace(10),
                    getCustomFont("Kuda Bank", 16.5, h6, 1, letterSpacing: 1.4),
                  ],
                ),
                getVerSpace(20),
                getCustomFont("STATUS", 12, greyColor, 1, letterSpacing: 1.4),
                getVerSpace(6),
                Row(
                  children: [
                    getSvgImage("green_dot.svg", height: 10, width: 10),
                    getHorSpace(10),
                    getCustomFont("Successful", 16.5, h6, 1,
                        letterSpacing: 1.4),
                  ],
                ),
                getVerSpace(20),
                getCustomFont("TRANSACTION REFERENCE", 12, greyColor, 1,
                    letterSpacing: 1.4),
                getVerSpace(6),
                Row(
                  children: [
                    getCustomFont(
                        "874tkmfknvnbcajnuahaf9wfhifjnskj", 16.5, h6, 1,
                        letterSpacing: 1.4),
                    getHorSpace(10),
                    getSvgImage("copy.svg", height: 24, width: 24),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  transactionDetails(BuildContext context) {
    return Row(
      children: [
        getCustomFont("Transaction Details", 20, h6, 1,
            fontWeight: FontWeight.w600),
        const Spacer(),
        TextButton(
            onPressed: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: grey100,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  getSvgImage("share.svg"),
                  getHorSpace(5),
                  getCustomFont("Share", 14, grey700, 1,
                      fontWeight: FontWeight.w600)
                ],
              ),
            ))
      ],
    );
  }
}
