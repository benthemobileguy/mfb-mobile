import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/view/home/cards/presentation/view/cards_screen.dart';
import 'package:tampay_mobile/app/view/home/home_screen.dart';
import 'package:tampay_mobile/app/view/home/profile/profile_screen.dart';
import 'package:tampay_mobile/app/view/home/send/send_money_screen.dart';
import 'package:tampay_mobile/theme/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/data_file.dart';
import '../../models/model_item.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int position = 0;

  void close() {
    Constant.closeApp();
  }

  List<Widget> tabList = [
    const HomeScreen(),
    const SendMoneyScreen(),
    const CardsScreen(),
    const ProfileScreen(),
  ];
  List<ModelItem> itemLists = DataFile.itemList;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: colorBg,
          body: tabList[position],
          bottomNavigationBar: bottomNavigationBar(),
        ),
        onWillPop: () async {
          close();
          return false;
        });
  }

  Container bottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
      height: FetchPixels.getPixelHeight(85),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.generate(itemLists.length, (index) {
          ModelItem modelItem = itemLists[index];
          return GestureDetector(
              onTap: () {
                setState(() {
                  position = index;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getSvgImage(modelItem.image ?? "",
                      color: position == index ? successGreen : grey400Color),
                  getHorSpace(FetchPixels.getPixelHeight(8)),
                  getCustomFont(modelItem.name ?? '', 13,
                      position == index ? successGreen : grey400Color, 1,
                      fontWeight: FontWeight.w500)
                ],
              ));
        }),
      ), // child:
    );
  }
}
