import 'package:flutter/material.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../theme/color_data.dart';

class VerifyDialog extends StatefulWidget {
  String title;
  String description;
  Function onOk;
  String okText;
  String? imagePath;
  VerifyDialog(
      {super.key,
      required this.title,
      required this.onOk,
      required this.okText,
      required this.description,
      this.imagePath});

  @override
  State<VerifyDialog> createState() => _VerifyDialogState();
}

class _VerifyDialogState extends State<VerifyDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return ScaleTransition(
      scale: scaleAnimation,
      child: Dialog(
          insetPadding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(16))),
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getVerSpace(FetchPixels.getPixelHeight(40)),
              getSvgImage(widget.imagePath ?? "tampay_logo.svg",
                  width: 50, height: 50),
              getVerSpace(FetchPixels.getPixelHeight(27)),
              getCustomFont(widget.title, 20, Colors.black, 1,
                  fontWeight: FontWeight.w700),
              getVerSpace(FetchPixels.getPixelHeight(8)),
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(20)),
                getMultilineCustomFont(widget.description, 13.5, Colors.black,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    txtHeight: FetchPixels.getPixelHeight(1.5)),
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(20)),
                getButton(context, primaryColor, widget.okText, Colors.white,
                    widget.onOk, 16,
                    weight: FontWeight.w600,
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                    buttonHeight: FetchPixels.getPixelHeight(60)),
              ),
              getVerSpace(FetchPixels.getPixelHeight(40)),
            ],
          )),
    );
  }
}
