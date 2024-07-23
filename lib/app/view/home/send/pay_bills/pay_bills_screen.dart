import 'package:flutter/material.dart';
import '../../../../../base/constant.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../../theme/color_data.dart';
import '../../../../routes/app_routes.dart';

class PayBillsScreen extends StatefulWidget {
  const PayBillsScreen({super.key});

  @override
  State<PayBillsScreen> createState() => _PayBillsScreenState();
}

class _PayBillsScreenState extends State<PayBillsScreen> {
  final List<Map<String, dynamic>> gridItems = [
    {
      "icon": "electricity.svg",
      "text": "Electricity",
      "screen": Routes.electricityRoute
    },
    {"icon": "airtime.svg", "text": "Airtime", "screen": Routes.airtimeRoute},
    {"icon": "internet.svg", "text": "Internet", "screen": Routes.internetRoute},
    {"icon": "tv.svg", "text": "TV", "screen": Routes.tvRoute},
    {
      "icon": "insurance.svg",
      "text": "Insurance",
      "screen": Routes.insuranceRoute
    },
    {"icon": "travel.svg", "text": "Travel", "screen": Routes.travelRoute},
  ];

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
                    child: getCustomFont("Pay Bills", 14, h6, 1,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  getHorSpace(55)
                ],
              ),
              getVerSpace(20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: gridItems.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Constant.sendToNext(
                            context, gridItems[index]['screen']!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: grey100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getSvgImage(gridItems[index]['icon']!,
                                height: 28, width: 28),
                            const SizedBox(height: 10),
                            getCustomFont(
                                gridItems[index]['text']!, 14, grey650, 1,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
