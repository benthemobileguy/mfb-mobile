import 'dart:ui';

Color textColor = "#6E768A".toColor();
Color blueColor = "#2B66FF".toColor();
Color intro1 = "#ECF4FF".toColor();
Color intro2 = "#FFF4EC".toColor();
Color grey600 = "#F7F9FC".toColor();
Color intro3 = "#F7ECFF".toColor();
Color grey400 = "#F7F9FC".toColor();
Color grey650 = "#475367".toColor();
Color successLightColor ="#EFFEF0".toColor();
Color successColor = blueColor.withOpacity(0.10);
Color shadowColor = blueColor.withOpacity(0.10);
Color skipColor = "#6E768A".toColor();
Color errorColor = "#DD524D".toColor();
Color borderColor = "#F5B546".toColor();
Color yellowColorBg = "#FEF6E7".toColor();
Color greenColor = "#0E871D".toColor();
Color yellowColor = "#F3A218".toColor();
Color colorBg = "#F4F4F4".toColor();
Color containerShadow = "#E0E9F5".toColor();
Color grey700 = "#344054".toColor();
Color yellowBg = "#F7D394".toColor();
Color h6 = "#1D2739".toColor();
Color textFieldActiveColor = "#41E755".toColor();
Color greyColor300 = "#D0D5DD".toColor();
Color successGreen = "#0F973D".toColor();
Color grey100 = "#F0F2F5".toColor();
Color redColor2 = "#D42620".toColor();
Color grey900Color = "#101928".toColor();
Color grey400Color = "#98A2B3".toColor();
Color blue = "#141D57".toColor();
Color teal = "#DCDCDC".toColor();
Color lightBlue = "#D9E7FF".toColor();
Color subtextColor = "#6E768A".toColor();
Color redColor = "#DD3333".toColor();
Color grayColor = "#E4E7EC".toColor();
Color greyColor = "#667185".toColor();
Color success2Color = "#099137".toColor();
Color greenSuccessColor = "#015B20".toColor();
Color orangeColor = "#F56D40".toColor();
Color primaryColor = "#0EB622".toColor();
Color buttonColor = '#F0F5FF'.toColor();
Color paymentBg = "#F2F3F8".toColor();
Color success = "#009C49".toColor();
Color error = "#DD3333".toColor();
Color priceColor = "#F1F5FF".toColor();
Color bgColor = "#E3F3FF".toColor();
Color errorbg = "#F9E7E7".toColor();
Color successBg = '#E7F9EF'.toColor();

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
