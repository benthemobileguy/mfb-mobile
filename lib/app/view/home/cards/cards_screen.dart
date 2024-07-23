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
  @override
  Widget build(BuildContext context) {
    const cardDetails = [
      CardDetail(
        cardBgAsset: 'assets/images/card1bg.jpg',
        balance: '200,000.60',
        cardNumber: '4657',
      ),
      CardDetail(
          cardBgAsset: 'assets/images/card3bg.jpg',
          balance: '848,900.30',
          cardNumber: '3486'),
      CardDetail(
          cardBgAsset: 'assets/images/card2bg.jpg',
          balance: '350,800.90',
          cardNumber: '6343'),
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
                    getCustomFont("United States Dollar", 14, grey600, 1,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Row(
                  children: [
                    getCustomFont("Master Card", 14, grey600, 1,
                        fontWeight: FontWeight.w500),
                    getHorSpace(FetchPixels.getPixelWidth(10)),
                    getCustomFont("Balance: \$500.43", 14, grey600, 1,
                        fontWeight: FontWeight.w500),
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
                        numberOfCardsDisplayed: 3,
                        scale: 0.95,
                        backCardOffset: const Offset(18, -15),
                      ),
                    ),
                  ),
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                const RecentTransactions()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
