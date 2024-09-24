import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/view/transactions/presentation/controller/transactions_controller.dart';
import 'package:tampay_mobile/theme/color_data.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';

class RecentTransactions extends ConsumerStatefulWidget {
  const RecentTransactions({super.key});

  @override
  ConsumerState<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends ConsumerState<RecentTransactions> {
  @override
  Widget build(BuildContext context) {
    final recentTransactionsController =
        ref.watch(transactionsControllerProvider);

    // Safely checking if recentTransactionsList and data are not null and data is not empty
    final transactions =
        recentTransactionsController.recentTransactionsList?.data;

    if (transactions != null && transactions.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize
            .min, // Set mainAxisSize to min to prevent infinite expansion
        children: [
          getPaddingWidget(
            const EdgeInsets.symmetric(horizontal: 14),
            Row(
              children: [
                getCustomFont("Recent Transactions", 16, grey700, 1,
                    fontWeight: FontWeight.w600),
                const Spacer(),
                getCustomFont(
                  "View All",
                  13,
                  h6,
                  1,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          SizedBox(
            height: 200, // Adjust the height as needed
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling within ListView.builder
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return customTrailingLeadingListTile(
                  transaction.narration ??
                      "Unknown", // Use narration or a fallback
                  15,
                  h6,
                  1,
                  leadingImagePath:
                      "kuda.png", // Replace with actual path if available
                  trailingText: "${transaction.currency} ${transaction.amount}",
                  subtitleText: transaction.createdAt ?? "No Date",
                  trailingFontColor: transaction.transactionType == "debit"
                      ? redColor
                      : primaryColor, // Adjust color based on transaction type
                  fontWeight: FontWeight.w500,
                  onTap: () {
                    // Handle tile tap if needed
                  },
                );
              },
            ),
          ),
        ],
      );
    } else {
      return getPaddingWidget(
        EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCustomFont("Recent Transactions", 16, grey650, 1,
                fontWeight: FontWeight.w600),
            getVerSpace(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getSvgImage("clock.svg", width: 16, height: 16),
                getHorSpace(10),
                getCustomFont("No Transactions yet", 15, grey400Color, 1,
                    fontWeight: FontWeight.normal),
              ],
            ),
            getVerSpace(40),
          ],
        ),
      );
    }
  }
}
