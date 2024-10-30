import 'package:flutter/material.dart';
import '../../../../base/constant.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../theme/color_data.dart';
import '../../../routes/app_routes.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  SearchController searchController = SearchController();
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
              getCustomFont("Send", 18, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getSearchWidget(context, searchController, "Search Anything",
                  false, () {}, (value) {}),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              customLeadingListTile("Bank Transfer", 15, h6, 1,
                  trailingImagePath: "chevron_right.svg",
                  subtitle: "Transfer funds between banks",
                  leadingImagePath: "bank_transfer.svg",
                  fontWeight: FontWeight.w500, onTap: () {
                Constant.sendToNext(context, Routes.bankTransferRoute);
              }),
              getVerSpace(FetchPixels.getPixelHeight(15)),
              customLeadingListTile("Send Via Tampay Tag", 15, h6, 1,
                  trailingImagePath: "chevron_right.svg",
                  subtitle: "Transfer between tampay accounts",
                  leadingImagePath: "send_tampay.svg",
                  fontWeight: FontWeight.w500, onTap: () {
                Constant.sendToNext(context, Routes.sendWithTampayRoute);
              }),
              getVerSpace(FetchPixels.getPixelHeight(15)),
              customLeadingListTile("Pay Bills", 15, h6, 1,
                  subtitle: "Pay for all your bills",
                  trailingImagePath: "chevron_right.svg",
                  leadingImagePath: "pay_bills.svg",
                  fontWeight: FontWeight.w500, onTap: () {
                Constant.sendToNext(context, Routes.payBillsRoute);
              }),
              getVerSpace(FetchPixels.getPixelHeight(15)),
              customLeadingListTile("QR Code Scan", 15, h6, 1,
                  subtitle: "Send or receive using your unique QR Code",
                  trailingImagePath: "chevron_right.svg",
                  leadingImagePath: "qr_code.svg",
                  fontWeight: FontWeight.w500, onTap: () {
                showComingSoonDialog(context);
              }),
              getVerSpace(FetchPixels.getPixelHeight(15)),
              customLeadingListTile("NFC Transfer", 15, h6, 1,
                  subtitle: "Send money by tapping the receivers phone",
                  trailingImagePath: "chevron_right.svg",
                  leadingImagePath: "nfc_transfer.svg",
                  fontWeight: FontWeight.w500, onTap: () {
                showComingSoonDialog(context);
              }),
              getVerSpace(FetchPixels.getPixelHeight(15)),
              customLeadingListTile("Offline Transfers", 15, h6, 1,
                  subtitle: "Send money without internet connection",
                  trailingImagePath: "chevron_right.svg",
                  leadingImagePath: "offline_transfers.svg",
                  fontWeight: FontWeight.w500, onTap: () {
                showComingSoonDialog(context);
              }),
            ],
          ),
        ),
      )),
    );
  }
}
