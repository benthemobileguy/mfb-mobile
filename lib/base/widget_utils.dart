import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tampay_mobile/base/custom_progess_dialog.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import '../theme/color_data.dart';
import 'constant.dart';

Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}

Widget getAssetImage(String image,
    {double? width,
    double? height,
    Color? color,
    double? opacity,
    BoxFit boxFit = BoxFit.contain}) {
  return Opacity(
    opacity: opacity ?? 1.0,
    child: Image.asset(
      Constant.assetImagePath + image,
      color: color,
      width: width,
      height: height,
      fit: boxFit,
      scale: FetchPixels.getScale(),
    ),
  );
}

Widget backButtonWidget(String image,
    {double? width,
    double? height,
    Color? color,
    double? opacity,
    BuildContext? context,
    BoxFit boxFit = BoxFit.contain}) {
  return TextButton(
    onPressed: () {
      Navigator.pop(context!);
    },
    style: ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
    ),
    child: SizedBox(
      width: 55,
      child: Row(
        children: [
          SvgPicture.asset(
            Constant.assetImagePath + image,
            width: width,
            height: height,
            fit: boxFit,
          ),
          SizedBox(width: FetchPixels.getPixelHeight(8)),
          Text(
            "Back",
            style: TextStyle(
              color: grey700,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              fontFamily: Constant.fontsFamily,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget getSvgImage(String image,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain}) {
  return SvgPicture.asset(
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
  );
}

Widget getPngImage(String image,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain}) {
  return Image.asset(
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
  );
}

Widget getPaddingWidget(EdgeInsets edgeInsets, Widget widget) {
  return Padding(
    padding: edgeInsets,
    child: widget,
  );
}

Widget getRichText(
    String firstText,
    Color firstColor,
    FontWeight firstWeight,
    double firstSize,
    String secondText,
    Color secondColor,
    FontWeight secondWeight,
    double secondSize,
    String thirdText,
    {TextAlign textAlign = TextAlign.center,
    double? txtHeight}) {
  return RichText(
    textScaleFactor: FetchPixels.getTextScale(),
    textAlign: textAlign,
    text: TextSpan(
        text: firstText,
        style: TextStyle(
          color: firstColor,
          fontWeight: firstWeight,
          fontFamily: Constant.fontsFamily,
          fontSize: firstSize,
          height: txtHeight,
        ),
        children: [
          TextSpan(
              text: secondText,
              style: TextStyle(
                  color: secondColor,
                  fontWeight: secondWeight,
                  fontFamily: Constant.fontsFamily,
                  fontSize: secondSize,
                  height: txtHeight)),
          TextSpan(
              text: thirdText,
              style: TextStyle(
                color: firstColor,
                fontWeight: firstWeight,
                fontFamily: Constant.fontsFamily,
                fontSize: firstSize,
                height: txtHeight,
              ))
        ]),
  );
}

DecorationImage getDecorationAssetImage(BuildContext buildContext, String image,
    {BoxFit fit = BoxFit.contain}) {
  return DecorationImage(
      image: AssetImage((Constant.assetImagePath) + image),
      fit: fit,
      scale: FetchPixels.getScale());
}

Future<void> showCustomDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible:
        false, // Prevent dismissal by tapping outside the dialog
    builder: (BuildContext context) {
      return const CustomProgressDialog();
    },
  );
}

ToastFuture showToast(BuildContext context, String message) {
  return //Interactive toast, set [isIgnoring] false.
      showToastWidget(
    animation: StyledToastAnimation.slideFromLeftFade,
    reverseAnimation: StyledToastAnimation.slideToBottom,
    position: StyledToastPosition.top,
    startOffset: const Offset(-1.0, 0.0),
    reverseEndOffset: const Offset(0.0, -1.0),
    duration: const Duration(seconds: 4),
    //Animation duration   animDuration * 2 <= duration
    animDuration: const Duration(seconds: 1),
    curve: Curves.easeInOut,
    reverseCurve: Curves.fastOutSlowIn,
    Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: successGreen),
        color: successLightColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: getSvgImage("checkmark.svg", width: 35, height: 35),
          ),
          getHorSpace(5),
          getCustomFont(message, 14, h6, 1),
        ],
      ),
    ),
    context: context,
    isIgnoring: true,
  );
}

ToastFuture showErrorToast(BuildContext context, String message) {
  return //Interactive toast, set [isIgnoring] false.
      showToastWidget(
    animation: StyledToastAnimation.slideFromLeftFade,
    reverseAnimation: StyledToastAnimation.slideToBottom,
    position: StyledToastPosition.top,
    startOffset: const Offset(-1.0, 0.0),
    reverseEndOffset: const Offset(0.0, -1.0),
    duration: const Duration(seconds: 4),
    //Animation duration   animDuration * 2 <= duration
    animDuration: const Duration(seconds: 1),
    curve: Curves.easeInOut,
    reverseCurve: Curves.fastOutSlowIn,
    Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: redColor2),
        color: error50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: getSvgImage("cancel_circle.svg", width: 35, height: 35),
          ),
          getHorSpace(5),
          getCustomFont(message, 14, h6, 1),
        ],
      ),
    ),
    context: context,
    isIgnoring: true,
  );
}

Widget getCustomFont(String text, double fontSize, Color fontColor, int maxLine,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    double? letterSpacing,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
    textScaleFactor: FetchPixels.getTextScale(),
  );
}

Future showCustomBottomSheet(
    BuildContext context, Widget widget, double height) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget,
        ),
      );
    },
  );
}

copyItem(
  BuildContext context,
  String title,
  String subtitle,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration:
        BoxDecoration(color: grey100, borderRadius: BorderRadius.circular(16)),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            getCustomFont(title, 13, greyColor, 1,
                letterSpacing: 1.1, fontWeight: FontWeight.w500),
            getVerSpace(FetchPixels.getPixelHeight(14)),
            getCustomFont(subtitle, 14, h6, 1, fontWeight: FontWeight.w500),
          ],
        ),
        const Spacer(),
        InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: subtitle));
              showToast(context, "Copied to clipboard");
            },
            child: getSvgImage("copy.svg"))
      ],
    ),
  );
}

Widget customTrailingLeadingListTile(
    String text, double fontSize, Color fontColor, int maxLine,
    {String fontFamily = Constant.fontsFamily,
    String trailingText = "",
    String subtitleText = "",
    Color? trailingFontColor,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.w600,
    double? letterSpacing,
    TextAlign textAlign = TextAlign.start,
    double? txtHeight,
    required String leadingImagePath,
    required VoidCallback onTap}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        text,
        overflow: overflow,
        style: TextStyle(
          decoration: decoration,
          fontSize: fontSize,
          fontStyle: FontStyle.normal,
          color: fontColor,
          letterSpacing: letterSpacing,
          fontFamily: fontFamily,
          height: txtHeight,
          fontWeight: fontWeight,
        ),
        maxLines: maxLine,
        softWrap: true,
        textAlign: textAlign,
        textScaleFactor: FetchPixels.getTextScale(),
      ),
    ),
    subtitle: getCustomFont(subtitleText, 14, grey400Color, maxLine),
    leading: getPngImage(leadingImagePath, width: 40, height: 40),
    trailing: getCustomFont(
        trailingText, 14.5, trailingFontColor ?? Colors.grey, 1,
        fontWeight: FontWeight.w600),
    onTap: onTap,
  );
}

Widget profileImageWidget() {
  return getAssetImage("profile_photo.png",
      height: FetchPixels.getPixelHeight(48),
      width: FetchPixels.getPixelHeight(48));
}

Widget customLeadingListTile(
    String text, double fontSize, Color fontColor, int maxLine,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.w600,
    double? letterSpacing,
    String? subtitle,
    TextAlign textAlign = TextAlign.start,
    double? txtHeight,
    required String trailingImagePath,
    required String leadingImagePath,
    required VoidCallback onTap}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
      text,
      overflow: overflow,
      style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight,
      ),
      maxLines: maxLine,
      softWrap: true,
      textAlign: textAlign,
      textScaleFactor: FetchPixels.getTextScale(),
    ),
    leading: getSvgImage(leadingImagePath, width: 35, height: 35),
    subtitle: Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: getCustomFont(subtitle ?? "", 12.5, greyColor, 1),
    ),
    trailing: getSvgImage(trailingImagePath, width: 16, height: 16),
    onTap: onTap,
  );
}

Widget customListTile(
    String text, double fontSize, Color fontColor, int maxLine,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.w600,
    double? letterSpacing,
    TextAlign textAlign = TextAlign.start,
    double? txtHeight,
    required String trailingImagePath,
    required VoidCallback onTap}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
      text,
      overflow: overflow,
      style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight,
      ),
      maxLines: maxLine,
      softWrap: true,
      textAlign: textAlign,
      textScaleFactor: FetchPixels.getTextScale(),
    ),
    trailing: getSvgImage(trailingImagePath, width: 16, height: 16),
    onTap: onTap,
  );
}

Widget getMultilineCustomFont(String text, double fontSize, Color fontColor,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight = 1.0}) {
  return Text(
    text,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    textAlign: textAlign,
    textScaleFactor: FetchPixels.getTextScale(),
  );
}

BoxDecoration getButtonDecoration(Color bgColor,
    {BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow> shadow = const [],
    DecorationImage? image}) {
  return BoxDecoration(
      color: bgColor,
      borderRadius: borderRadius,
      border: border,
      boxShadow: shadow,
      image: image);
}

Widget getButton(BuildContext context, Color bgColor, String text,
    Color textColor, Function()? function, double fontSize,
    {bool isBorder = false,
    EdgeInsetsGeometry? insetsGeometry,
    borderColor = Colors.transparent,
    FontWeight weight = FontWeight.bold,
    bool isIcon = false,
    String? image,
    Color? imageColor,
    double? imageWidth,
    double? imageHeight,
    bool smallFont = false,
    double? buttonHeight,
    double? buttonWidth,
    List<BoxShadow> boxShadow = const [],
    EdgeInsetsGeometry? insetsGeometryPadding,
    BorderRadius? borderRadius,
    double? borderWidth}) {
  return InkWell(
    onTap: function,
    child: Container(
      margin: insetsGeometry,
      padding: insetsGeometryPadding,
      width: buttonWidth,
      height: buttonHeight,
      decoration: getButtonDecoration(
        bgColor,
        borderRadius: borderRadius,
        shadow: boxShadow,
        border: (isBorder)
            ? Border.all(color: borderColor, width: borderWidth!)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (isIcon) ? getSvgImage(image!) : getHorSpace(0),
          (isIcon)
              ? getHorSpace(FetchPixels.getPixelHeight(10))
              : getHorSpace(0),
          getCustomFont(text, fontSize, textColor, 1,
              textAlign: TextAlign.center,
              fontWeight: weight,
              fontFamily: Constant.fontsFamily)
        ],
      ),
    ),
  );
}

Widget searchWidget(
    BuildContext context,
    Color bgColor,
    TextEditingController controller,
    String hint,
    Color textColor,
    Function function,
    double fontsize,
    {bool isBorder = false,
    EdgeInsetsGeometry? insetsGeometry,
    borderColor = Colors.transparent,
    FontWeight weight = FontWeight.bold,
    bool prefixIcon = false,
    bool suffixIcon = false,
    String? prefixImage,
    String? suffixImage,
    Color? imageColor,
    double? imageWidth,
    double? imageHeight,
    bool smallFont = false,
    double? buttonHeight,
    double? buttonWidth,
    List<BoxShadow> boxShadow = const [],
    EdgeInsetsGeometry? insetsGeometryPadding,
    BorderRadius? borderRadius,
    double? borderWidth,
    String fontFamily = Constant.fontsFamily}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      margin: insetsGeometry,
      padding: insetsGeometryPadding,
      width: buttonWidth,
      height: buttonHeight,
      decoration: getButtonDecoration(
        bgColor,
        borderRadius: borderRadius,
        shadow: boxShadow,
        border: (isBorder)
            ? Border.all(color: borderColor, width: borderWidth!)
            : null,
      ),
      child: Row(
        children: [
          if (prefixIcon)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelHeight(16)),
              child: getSvgImage(prefixImage!,
                  width: imageWidth, height: imageHeight),
            ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) {
                function();
              },
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: fontsize,
                  fontFamily: fontFamily,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: fontsize,
                fontFamily: fontFamily,
              ),
            ),
          ),
          if (suffixIcon)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelHeight(16)),
              child: getSvgImage(suffixImage!,
                  width: imageWidth, height: imageHeight),
            ),
        ],
      ),
    ),
  );
}

Widget getButtonWithIcon(BuildContext context, Color bgColor, String text,
    Color textColor, Function function, double fontsize,
    {bool isBorder = false,
    EdgeInsetsGeometry? insetsGeometry,
    borderColor = Colors.transparent,
    FontWeight weight = FontWeight.bold,
    bool prefixIcon = false,
    bool sufixIcon = false,
    String? prefixImage,
    String? suffixImage,
    Color? imageColor,
    double? imageWidth,
    double? imageHeight,
    bool smallFont = false,
    double? buttonHeight,
    double? buttonWidth,
    List<BoxShadow> boxShadow = const [],
    EdgeInsetsGeometry? insetsGeometrypadding,
    BorderRadius? borderRadius,
    double? borderWidth,
    String fontFamily = Constant.fontsFamily}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      margin: insetsGeometry,
      padding: insetsGeometrypadding,
      width: buttonWidth,
      height: buttonHeight,
      decoration: getButtonDecoration(
        bgColor,
        borderRadius: borderRadius,
        shadow: boxShadow,
        border: (isBorder)
            ? Border.all(color: borderColor, width: borderWidth!)
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              getHorSpace(FetchPixels.getPixelHeight(18)),
              (prefixIcon) ? getSvgImage(prefixImage!) : getHorSpace(0),
              (prefixIcon)
                  ? getHorSpace(FetchPixels.getPixelHeight(12))
                  : getHorSpace(0),
              getCustomFont(text, fontsize, textColor, 1,
                  textAlign: TextAlign.center,
                  fontWeight: weight,
                  fontFamily: fontFamily)
            ],
          ),
          Row(
            children: [
              (sufixIcon) ? getSvgImage(suffixImage!) : getHorSpace(0),
              (sufixIcon)
                  ? getHorSpace(FetchPixels.getPixelHeight(18))
                  : getHorSpace(0),
            ],
          )
        ],
      ),
    ),
  );
}

Widget getDefaultTextFiledWithLabel(
    BuildContext context, String s, TextEditingController textEditingController,
    {bool withPrefix = false,
    bool withSuffix = false,
    bool minLines = false,
    double suffixImageHeight = 24,
    double suffixImageWidth = 24,
    String? title = "",
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isPass = false,
    bool isEnable = true,
    EdgeInsetsGeometry? contentPadding = EdgeInsets.zero,
    double? height,
    TextInputType textInputType = TextInputType.text,
    double? imageHeight,
    double? imageWidth,
    String? image,
    String? suffixImage,
    Function()? onTap,
    Function()? imageFunction,
    AlignmentGeometry alignmentGeometry = Alignment.centerLeft,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged}) {
  FocusNode myFocusNode = FocusNode();
  Color color = greyColor300;

  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew = mqData.copyWith(
          textScaler: TextScaler.linear(FetchPixels.getTextScale()));

      return AbsorbPointer(
        absorbing: !isEnable,
        child: Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              setState(() {
                color = textFieldActiveColor;
                myFocusNode.canRequestFocus = true;
              });
            } else {
              setState(() {
                color = borderColor;
                myFocusNode.canRequestFocus = false;
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: TextStyle(
                  color: grey900Color,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: Constant.fontsFamily,
                ),
              ),
              if (title!.isNotEmpty) getVerSpace(6),
              Container(
                height: height,
                margin: margin,
                alignment: alignmentGeometry,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: color, width: FetchPixels.getPixelHeight(1)),
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(12))),
                child: MediaQuery(
                  data: mqDataNew,
                  child: Row(
                    children: [
                      (!withPrefix)
                          ? getHorSpace(FetchPixels.getPixelHeight(16))
                          : Padding(
                              padding: EdgeInsets.only(
                                  right: FetchPixels.getPixelHeight(12),
                                  left: FetchPixels.getPixelHeight(18)),
                              child: getSvgImage(image!,
                                  height: FetchPixels.getPixelHeight(24),
                                  width: FetchPixels.getPixelHeight(24)),
                            ),
                      Expanded(
                        child: TextField(
                          inputFormatters: inputFormatters,
                          maxLines: (minLines) ? null : 1,
                          controller: textEditingController,
                          obscuringCharacter: "*",
                          autofocus: false,
                          obscureText: isPass,
                          keyboardType: textInputType,
                          showCursor: true,
                          focusNode: myFocusNode,
                          onTap: onTap,
                          textDirection: TextDirection.ltr,
                          onChanged: onChanged,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontFamily: Constant.fontsFamily),
                          decoration: InputDecoration(
                              contentPadding: contentPadding,
                              border: InputBorder.none,
                              hintText: s,
                              hintStyle: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  fontFamily: Constant.fontsFamily)),
                        ),
                      ),
                      (!withSuffix)
                          ? getHorSpace(FetchPixels.getPixelHeight(16))
                          : Padding(
                              padding: EdgeInsets.only(
                                  right: FetchPixels.getPixelHeight(18),
                                  left: FetchPixels.getPixelHeight(12)),
                              child: InkWell(
                                onTap: imageFunction,
                                child: getSvgImage(suffixImage!,
                                    height: FetchPixels.getPixelHeight(
                                        suffixImageHeight),
                                    width: FetchPixels.getPixelHeight(
                                        suffixImageWidth)),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget dragIndicator(BuildContext context) {
  return Center(
    child: Container(
      width: 62,
      height: 6,
      decoration: BoxDecoration(
        color: greyColor300,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

Widget accountBalance(BuildContext context) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: grey400,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          getSvgImage("ngn_logo.svg", height: 18, width: 18),
          getHorSpace(FetchPixels.getPixelHeight(5)),
          getCustomFont(
              "Nigerian Naira • Balance :₦1,198,385", 14.5, grey650, 1,
              fontWeight: FontWeight.w500),
        ],
      ),
    ),
  );
}

Widget appBar(BuildContext context, String title) {
  return Row(
    children: [
      backButtonWidget("back.svg", context: context),
      const Spacer(),
      Center(
        child: getCustomFont(title, 15, h6, 1, fontWeight: FontWeight.w600),
      ),
      const Spacer(),
      getHorSpace(55)
    ],
  );
}

Widget balance(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: grey600,
      borderRadius: BorderRadius.circular(20),
    ),
    child: getCustomFont("Balance :₦1,198,385", 14, grey650, 1,
        fontWeight: FontWeight.w500),
  );
}

Widget amountInput(BuildContext context,
    {Color borderColor = Colors.transparent}) {
  return Column(
    children: [
      Center(
        child: getCustomFont("AMOUNT", 12.5, grey650, 1,
            fontWeight: FontWeight.w600, letterSpacing: 1.7),
      ),
      getVerSpace(FetchPixels.getPixelHeight(5)),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getCustomFont("₦", 34, Colors.black, 1,
              fontWeight: FontWeight.w500, letterSpacing: 1.5),
          getCustomFont(
            "0.00",
            34,
            Colors.black,
            1,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      getVerSpace(FetchPixels.getPixelHeight(5)),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: yellowColor, width: 1),
            color: yellowColorBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: getCustomFont("+₦10 charge", 13, yellowColor, 1,
              fontWeight: FontWeight.w400),
        ),
      ),
    ],
  );
}

Widget getCardDateTextField(
  BuildContext context,
  String s,
  TextEditingController textEditingController,
  Color fontColor, {
  bool minLines = false,
  EdgeInsetsGeometry margin = EdgeInsets.zero,
  bool isPass = false,
  bool isEnable = true,
  double? height,
  required Function function,
}) {
  FocusNode myFocusNode = FocusNode();
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew = mqData.copyWith(
          textScaler: TextScaler.linear(FetchPixels.getTextScale()));

      return AbsorbPointer(
        absorbing: isEnable,
        child: Container(
          height: height,
          margin: margin,
          alignment: Alignment.centerLeft,
          padding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(18)),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12))),
          child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: MediaQuery(
                data: mqDataNew,
                child: TextField(
                  maxLines: (minLines) ? null : 1,
                  controller: textEditingController,
                  obscuringCharacter: "*",
                  autofocus: false,
                  focusNode: myFocusNode,
                  obscureText: isPass,
                  showCursor: true,
                  onTap: () {
                    function();
                  },
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: Constant.fontsFamily),
                  // textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: s,
                      hintStyle: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontFamily: Constant.fontsFamily)),
                ),
              )),
        ),
      );
    },
  );
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

Widget getCardEditText(BuildContext context, String s,
    TextEditingController textEditingController, Color fontColor,
    {bool withprefix = false,
    bool withSufix = false,
    bool minLines = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isPass = false,
    bool isEnable = true,
    double? height,
    double? imageHeight,
    double? imageWidth,
    String? image,
    String? suffiximage,
    required Function function,
    Function? imagefunction}) {
  FocusNode myFocusNode = FocusNode();
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew = mqData.copyWith(
          textScaler: TextScaler.linear(FetchPixels.getTextScale()));

      return AbsorbPointer(
        absorbing: isEnable,
        child: Container(
          height: height,
          margin: margin,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12))),
          child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: MediaQuery(
                data: mqDataNew,
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberFormatter(),
                  ],
                  maxLines: (minLines) ? null : 1,
                  controller: textEditingController,
                  maxLength: 19,
                  obscuringCharacter: "*",
                  autofocus: false,
                  focusNode: myFocusNode,
                  obscureText: isPass,
                  showCursor: true,
                  onTap: () {
                    function();
                  },
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: Constant.fontsFamily),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      counterText: "",
                      prefixIcon: (withprefix)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right: FetchPixels.getPixelHeight(12),
                                  left: FetchPixels.getPixelHeight(18)),
                              child: getSvgImage(image!,
                                  height: FetchPixels.getPixelHeight(24),
                                  width: FetchPixels.getPixelHeight(24)),
                            )
                          : null,
                      suffixIcon: (withSufix)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right: FetchPixels.getPixelHeight(18),
                                  left: FetchPixels.getPixelHeight(12)),
                              child: InkWell(
                                onTap: () {
                                  imagefunction!();
                                },
                                child: getSvgImage(suffiximage!,
                                    height: FetchPixels.getPixelHeight(24),
                                    width: FetchPixels.getPixelHeight(24)),
                              ),
                            )
                          : null,
                      border: InputBorder.none,
                      hintText: s,
                      hintStyle: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontFamily: Constant.fontsFamily)),
                ),
              )),
        ),
      );
    },
  );
}

Widget getCountryTextField(BuildContext context, String s,
    TextEditingController textEditingController, String code,
    {bool withprefix = false,
    bool withSufix = false,
    bool minLines = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isPass = false,
    bool isEnable = true,
    double? height,
    String? image,
    required Function function,
    Function? imagefunction}) {
  FocusNode myFocusNode = FocusNode();
  Color color = borderColor;
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew = mqData.copyWith(
          textScaler: TextScaler.linear(FetchPixels.getTextScale()));

      return AbsorbPointer(
        absorbing: isEnable,
        child: Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              setState(() {
                color = blueColor;
                myFocusNode.canRequestFocus = true;
              });
            } else {
              setState(() {
                color = borderColor;
                myFocusNode.canRequestFocus = false;
              });
            }
          },
          child: Container(
            height: height,
            margin: margin,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: color, width: FetchPixels.getPixelHeight(1)),
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(12))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getHorSpace(FetchPixels.getPixelHeight(18)),
                getAssetImage(image!,
                    width: FetchPixels.getPixelHeight(24),
                    height: FetchPixels.getPixelHeight(24)),
                getHorSpace(FetchPixels.getPixelHeight(12)),
                getCustomFont(code, 16, Colors.black, 1,
                    fontWeight: FontWeight.w400,
                    fontFamily: Constant.fontsFamily),
                getSvgImage("down_arrow.svg"),
                getHorSpace(FetchPixels.getPixelHeight(20)),
                Expanded(
                  child: MediaQuery(
                    data: mqDataNew,
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLines: (minLines) ? null : 1,
                      controller: textEditingController,
                      obscuringCharacter: "*",
                      autofocus: false,
                      focusNode: myFocusNode,
                      obscureText: isPass,
                      showCursor: true,
                      onTap: () {
                        function();
                      },
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontFamily: Constant.fontsFamily),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: s,
                          hintStyle: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontFamily: Constant.fontsFamily)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget getSearchWidget(
    BuildContext context,
    TextEditingController searchController,
    Function filterClick,
    ValueChanged<String> onChanged,
    {bool withPrefix = true}) {
  double height = FetchPixels.getPixelHeight(56);

  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew = mqData.copyWith(
          textScaler: TextScaler.linear(FetchPixels.getTextScale()));
      return Container(
        width: double.infinity,
        height: height,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: borderColor, width: FetchPixels.getPixelHeight(1)),
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: FetchPixels.getPixelHeight(13),
                  left: FetchPixels.getPixelHeight(16)),
              child: getSvgImage("search.svg",
                  height: FetchPixels.getPixelHeight(24),
                  width: FetchPixels.getPixelHeight(24)),
            ),
            Expanded(
              flex: 1,
              child: MediaQuery(
                  data: mqDataNew,
                  child: TextField(
                    enabled: true,
                    onTap: () {
                      filterClick();
                    },
                    autofocus: false,
                    onChanged: onChanged,
                    textDirection: TextDirection.ltr,
                    textInputAction: TextInputAction.search,
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "Search Anything",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: grey400Color,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: Constant.fontsFamily)),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: Constant.fontsFamily),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  )),
            ),
            getHorSpace(FetchPixels.getPixelHeight(3)),
          ],
        ),
      );
    },
  );
}

Widget gettoolbarMenu(BuildContext context, String image, Function function,
    {bool istext = false,
    double? fontsize,
    String? title,
    Color? textColor,
    FontWeight? weight,
    String fontFamily = Constant.fontsFamily,
    bool isrightimage = false,
    String? rightimage,
    Function? rightFunction,
    bool isleftimage = true}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      (isleftimage)
          ? InkWell(
              onTap: () {
                function();
              },
              child: getSvgImage(image,
                  height: FetchPixels.getPixelHeight(24),
                  width: FetchPixels.getPixelHeight(24)))
          : Container(),
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: (istext)
              ? getCustomFont(title!, fontsize!, textColor!, 1,
                  fontWeight: weight!, fontFamily: fontFamily)
              : null,
        ),
      ),
      (isrightimage)
          ? InkWell(
              onTap: () {
                if (rightFunction != null) {
                  rightFunction();
                }
              },
              child: getSvgImage(rightimage!,
                  height: FetchPixels.getPixelHeight(24),
                  width: FetchPixels.getPixelHeight(24)))
          : Container(),
    ],
  );
}

Widget withoutleftIconToolbar(BuildContext context,
    {bool istext = false,
    double? fontsize,
    String? title,
    Color? textColor,
    FontWeight? weight,
    String fontFamily = Constant.fontsFamily,
    bool isrightimage = false,
    String? rightimage,
    Function? rightFunction}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: (istext)
              ? getCustomFont(title!, fontsize!, textColor!, 1,
                  fontWeight: weight!, fontFamily: fontFamily)
              : null,
        ),
      ),
      (isrightimage)
          ? InkWell(
              onTap: () {
                rightFunction!();
              },
              child: getSvgImage(rightimage!,
                  height: FetchPixels.getPixelHeight(24),
                  width: FetchPixels.getPixelHeight(24)))
          : Container(),
    ],
  );
}

Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}

Widget getDivider(Color color, double height, double thickness) {
  return Divider(
    color: color,
    height: height,
    thickness: thickness,
  );
}
