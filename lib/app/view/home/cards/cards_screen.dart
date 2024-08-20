import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tampay_mobile/app/view/home/cards/bank_card.dart';
import 'package:tampay_mobile/app/view/home/send/recent_transations.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import 'card_detail.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const cardDetails = [
      CardDetail(
        cardBgAsset: 'assets/images/card1bg.jpg',
        balance: '0',
        cardNumber: '4657',
      ),
    ];

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
                getVerSpace(FetchPixels.getPixelHeight(50)),
                Row(
                  children: [
                    getPngImage("usd_logo.png", width: 30, height: 30),
                    getHorSpace(FetchPixels.getPixelWidth(10)),
                    getCustomFont("United States Dollar", 14, grey650, 1,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: grey100,
                          borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: getCustomFont("Master Card", 14, grey650, 1,
                          fontWeight: FontWeight.w500),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(5)),
                    Container(
                      decoration: BoxDecoration(
                          color: grey100,
                          borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: getCustomFont("Balance: \$500.43", 14, grey650, 1,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(40)),
                AnimationConfiguration.staggeredList(
                  position: 0,
                  delay: const Duration(milliseconds: 200),
                  child: FadeInAnimation(
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 260,
                      child: CardSwiper(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        cardBuilder: (
                          context,
                          index,
                          horizontalOffsetPercentage,
                          verticalOffsetPercentage,
                        ) {
                          final cardDetail = cardDetails[index];
                          return GestureDetector(
                            onTap: () {
                              // Handle card tap here
                            },
                            child: BankCard(
                              balance: cardDetail.balance,
                              bankCardBgAsset: cardDetail.cardBgAsset,
                              bankCardNumber: cardDetail.cardNumber,
                            ),
                          );
                        },
                        cardsCount: cardDetails.length,
                        isLoop: true,
                        numberOfCardsDisplayed: 1,
                        scale: 0.95,
                        backCardOffset: const Offset(18, -15),
                      ),
                    ),
                  ),
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: grey600.withOpacity(0.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIconWithText('card_add.svg', 'Add money', () {
                        showCustomBottomSheet(
                            context,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                getVerSpace(FetchPixels.getPixelHeight(20)),
                                getCustomFont("Add Money", 16.5, grey700, 1,
                                    fontWeight: FontWeight.w700),
                                getVerSpace(FetchPixels.getPixelHeight(20)),
                                getDefaultTextFiledWithLabel(
                                  context,
                                  "₦0.00",
                                  onTap: () {},
                                  title: "Enter Amount",
                                  amountController,
                                  height: FetchPixels.getPixelHeight(60),
                                  withSuffix: true,
                                  withPrefix: true,
                                  suffixImage: "chevron_down_grey.svg",
                                  image: "britain_logo.svg",
                                  suffixImageHeight: 12,
                                  suffixImageWidth: 12,
                                  isEnable: false,
                                ),
                                getVerSpace(FetchPixels.getPixelHeight(10)),
                                getCustomFont("Balance :£16.30", 14, grey650, 1,
                                    fontWeight: FontWeight.w500),
                                const Spacer(),
                                getButton(context, primaryColor, "Fund card",
                                    Colors.white, () {
                                  showToast(context, "Card Funded Successfully");
                                  Navigator.pop(context);
                                }, 16,
                                    weight: FontWeight.w600,
                                    borderRadius: BorderRadius.circular(
                                        FetchPixels.getPixelHeight(15)),
                                    buttonHeight:
                                        FetchPixels.getPixelHeight(60)),
                                getVerSpace(20)
                              ],
                            ),
                            MediaQuery.of(context).size.height * 0.8);
                      }),
                      _buildIconWithText('freeze_card.svg', 'Freeze', () {
                        showCustomBottomSheet(
                            context,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getVerSpace(FetchPixels.getPixelHeight(10)),
                                getCustomFont("Freeze Card", 16.5, grey700, 1,
                                    fontWeight: FontWeight.w700),
                                getVerSpace(FetchPixels.getPixelHeight(12)),
                                getCustomFont(
                                    "Are you sure you want to freeze this card?",
                                    12.5,
                                    blue,
                                    1,
                                    fontWeight: FontWeight.w500),
                                getVerSpace(FetchPixels.getPixelHeight(30)),
                                Center(
                                  child: getSvgImage("freeze_card.svg",
                                      width: 70, height: 70),
                                ),
                                getVerSpace(FetchPixels.getPixelHeight(30)),
                                Row(
                                  children: [
                                    Expanded(
                                      child: getButton(context, primaryColor,
                                          "Cancel", Colors.white, () {
                                        Navigator.pop(context);
                                      }, 16,
                                          weight: FontWeight.w600,
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(15)),
                                          buttonHeight:
                                              FetchPixels.getPixelHeight(60)),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: getButton(context, greyColor300,
                                          "Freeze", Colors.white, () {
                                        showCustomBottomSheet(
                                            context,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                getVerSpace(
                                                    FetchPixels.getPixelHeight(
                                                        70)),
                                                Center(
                                                  child: getSvgImage(
                                                      "freeze_card.svg",
                                                      width: 70,
                                                      height: 70),
                                                ),
                                                getVerSpace(
                                                    FetchPixels.getPixelHeight(
                                                        20)),
                                                getCustomFont("Card frozen",
                                                    14.5, blue, 1,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                const Spacer(),
                                                getPngImage("inverted_card.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.5),
                                              ],
                                            ),
                                            MediaQuery.of(context).size.height *
                                                0.8);
                                      }, 16,
                                          weight: FontWeight.w600,
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(15)),
                                          buttonHeight:
                                              FetchPixels.getPixelHeight(60)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            MediaQuery.of(context).size.height * 0.35);
                      }),
                      _buildIconWithText('details_card.svg', 'Details', () {
                        showCustomBottomSheet(
                            context,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getVerSpace(FetchPixels.getPixelHeight(10)),
                                getCustomFont("Card Details", 16.5, grey700, 1,
                                    fontWeight: FontWeight.w700),
                                getVerSpace(FetchPixels.getPixelHeight(16)),
                                copyItem(
                                    context, "CARD NAME", "Mamudu Jeffrey"),
                                getVerSpace(10),
                                copyItem(context, "CARD NUMBER",
                                    "5496 1985 8458 4769"),
                                getVerSpace(10),
                                copyItem(context, "CVV", "549"),
                                getVerSpace(10),
                                copyItem(context, "EXPIRY DATE", "08/28"),
                                getVerSpace(10),
                                copyItem(context, "BILLING ADDRESS",
                                    "383 Madison Avenue in Midtown"),
                                getVerSpace(10),
                                copyItem(context, "ZIP CODE", "1234"),
                              ],
                            ),
                            MediaQuery.of(context).size.height * 0.75);
                      }),
                      _buildIconWithText('more_details.svg', 'More', () {
                        showToast(context, "Coming soon");
                      }),
                    ],
                  ),
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                const RecentTransactions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithText(String svgAsset, String label, Function() onTap) {
    return TextButton(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(0, 0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onTap,
      child: Column(
        children: [
          getSvgImage(svgAsset, width: 40, height: 40),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          getCustomFont(label, 14, grey700, 1, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}
