import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

import '../../../../../base/constant.dart';
import '../../../../routes/app_routes.dart';
import '../../../transactions/presentation/controller/transactions_controller.dart';

class TransactionSuccessfulScreen extends ConsumerStatefulWidget {
  const TransactionSuccessfulScreen({super.key});

  @override
  ConsumerState<TransactionSuccessfulScreen> createState() =>
      _TransactionSuccessfulScreenState();
}

class _TransactionSuccessfulScreenState
    extends ConsumerState<TransactionSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    final transactionsController = ref.read(transactionsControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Positioned Back Button at the top left
            Positioned(
              top: 10,
              left: 10,
              child: backButtonWidget("back.svg", context: context),
            ),
            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: getSvgImage("check.svg")),
                  getVerSpace(20),
                  getCustomFont("Transaction Successful", 16, grey700, 1,
                      fontWeight: FontWeight.w600),
                  getVerSpace(20),
                  getCustomFont(
                      "${transactionsController.transferResponse?.data?.amount}.00 is on it’s way to ${transactionsController.transferResponse?.data?.beneficiaryName}",
                      14.5,
                      grey700,
                      3,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.normal),
                  getVerSpace(20),
                  InkWell(
                    onTap: () {
                      Constant.sendToNext(
                          context, Routes.transactionDetailsRoute);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: getCustomFont(
                          "Share Transaction Details", 14.5, Colors.white, 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  getVerSpace(10),
                  InkWell(
                    onTap: () {
                      Constant.sendToNext(context, Routes.homeScreenRoute);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: getCustomFont(
                          "View Balance", 14.5, Colors.white, 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
