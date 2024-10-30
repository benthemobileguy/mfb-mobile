import 'package:flutter/material.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final Widget content;
  final Widget actions;
  final String? imagePath;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
    this.imagePath,
  });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(16)),
        ),
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getVerSpace(FetchPixels.getPixelHeight(40)),
            if (widget.imagePath != null)
              getSvgImage(widget.imagePath!, width: 50, height: 50),
            getVerSpace(FetchPixels.getPixelHeight(27)),
            getCustomFont(widget.title, 20, Colors.black, 1,
                fontWeight: FontWeight.w700),
            getVerSpace(FetchPixels.getPixelHeight(8)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelHeight(20)),
              child: widget.content,
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelHeight(20)),
              child: widget.actions, // Custom actions go here
            ),
            getVerSpace(FetchPixels.getPixelHeight(40)),
          ],
        ),
      ),
    );
  }
}
