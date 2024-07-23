import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/view/home/send/recent_transations.dart';
import 'package:tampay_mobile/theme/color_data.dart';
import '../../../../../base/constant.dart';
import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../routes/app_routes.dart';

class BankTransferScreen extends StatefulWidget {
  const BankTransferScreen({super.key});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController bankController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController narrationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                    child: getCustomFont("Bank Transfer", 15, h6, 1,
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
              getVerSpace(FetchPixels.getPixelHeight(20)),
              Center(
                child: SizedBox(
                  width: 350,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: greenColor,
                    dividerColor: grayColor,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: Constant.fontsFamily,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: Constant.fontsFamily,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: grey700,
                    indicatorColor: greenColor,
                    tabs: const [
                      Tab(text: 'Bank Transfer'),
                      Tab(text: 'Beneficiaries'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            getVerSpace(FetchPixels.getPixelHeight(30)),
                            getDefaultTextFiledWithLabel(
                              context,
                              "Select Bank",
                              title: "Bank",
                              bankController,
                              height: FetchPixels.getPixelHeight(60),
                              withSuffix: true,
                              suffixImageHeight: 12,
                              suffixImageWidth: 12,
                              suffixImage: "chevron_down_dark.svg",
                              isEnable: true,
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(20)),
                            getDefaultTextFiledWithLabel(
                              context,
                              "Enter Account Number",
                              title: "Account Number",
                              accountNoController,
                              height: FetchPixels.getPixelHeight(60),
                              isEnable: false,
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(30)),
                            getDefaultTextFiledWithLabel(
                              context,
                              "Describe transaction",
                              title: "Narration (optional)",
                              narrationController,
                              minLines: false,
                              height: FetchPixels.getPixelHeight(90),
                              contentPadding: const EdgeInsets.only(bottom: 40),
                              isEnable: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        children: [
                          getVerSpace(FetchPixels.getPixelHeight(30)),
                          const RecentTransactions(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              getButton(context, primaryColor, "Send", Colors.white, () {
                Constant.sendToNext(context, Routes.sendMoneyConfirmationRoute);
              }, 16,
                  weight: FontWeight.w600,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                  buttonHeight: FetchPixels.getPixelHeight(60)),
              getVerSpace(FetchPixels.getPixelHeight(30)),
            ],
          ),
        ),
      ),
    );
  }
}
