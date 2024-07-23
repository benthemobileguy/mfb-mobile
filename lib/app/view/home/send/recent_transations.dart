import 'package:flutter/material.dart';
import 'package:tampay_mobile/theme/color_data.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        getVerSpace(FetchPixels.getPixelHeight(10)),
        customTrailingLeadingListTile("Mamudu Jefferey", 15, h6, 1,
            leadingImagePath: "kuda.png",
            trailingText: "\$4,000",
            subtitleText: "Yesterday 4:15PM",
            trailingFontColor: primaryColor,
            fontWeight: FontWeight.w500,
            onTap: () {}),
        customTrailingLeadingListTile("Netflix", 15, h6, 1,
            leadingImagePath: "netflix.png",
            trailingText: "-\$2,500",
            subtitleText: "12/04/24 12:01PM",
            trailingFontColor: redColor,
            fontWeight: FontWeight.w500,
            onTap: () {}),
        customTrailingLeadingListTile("Netflix", 15, h6, 1,
            leadingImagePath: "netflix.png",
            trailingText: "-\$2,000",
            subtitleText: "12/04/24 12:01PM",
            trailingFontColor: redColor,
            fontWeight: FontWeight.w500,
            onTap: () {}),
        customTrailingLeadingListTile("George Kenny", 15, h6, 1,
            leadingImagePath: "zenith.png",
            trailingText: "\$35,736",
            subtitleText: "15/04/24 3:01PM",
            trailingFontColor: primaryColor,
            fontWeight: FontWeight.w500,
            onTap: () {}),
      ],
    );
  }
}
