import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:pinput/pinput.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

import '../controller/signup_controller.dart';

class SetPasscodeScreen extends ConsumerStatefulWidget {
  const SetPasscodeScreen({super.key});

  @override
  ConsumerState<SetPasscodeScreen> createState() => _SetPasscodeScreenState();
}

class _SetPasscodeScreenState extends ConsumerState<SetPasscodeScreen> {
  String text = "";
  String confirmPasscode = "";
  String newPasscode = "";
  bool isConfirmingPin = false;
  bool _forceErrorState = false; // Track if error state should be enforced
  FocusNode myFocusNode = FocusNode();
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Prevent the native keyboard from appearing when Pinput is focused
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        myFocusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _onKeyboardTap(String value) {
    if (text.length < 4) {
      setState(() {
        text = text + value;
        _pinController.text = text;
        if (text.length == 4) {
          if (isConfirmingPin) {
            confirmPasscode = text;
            _validatePin();
          } else {
            newPasscode = text;
            setState(() {
              isConfirmingPin = true;
              text = "";
              _pinController.clear();
            });
          }
        }
      });
    }
  }

  void _validatePin() {
    if (newPasscode != confirmPasscode) {
      setState(() {
        _pinController.clear();
        text = "";
        // Force the error state by setting forceErrorState to true
        _forceErrorState = true;
      });
    } else {
      createPasscode();
    }
  }

  void finishView() {
    Constant.closeApp();
  }

  @override
  Widget build(BuildContext context) {
    Color color = greyColor300;

    final defaultPinTheme = PinTheme(
      width: FetchPixels.getPixelHeight(60),
      height: FetchPixels.getPixelHeight(60),
      textStyle: TextStyle(
        fontSize: FetchPixels.getPixelHeight(24),
        color: grey900Color,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color, width: FetchPixels.getPixelHeight(1)),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        border: Border.all(color: errorColor),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: backButtonWidget("back.svg", context: context)),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              const Spacer(),
              Center(child: getSvgImage("lock.svg", width: 40, height: 40)),
              getVerSpace(FetchPixels.getPixelHeight(15)),
              Center(
                child: getCustomFont(
                  isConfirmingPin ? "Confirm Passcode" : "Set Passcode",
                  14.5,
                  grey700,
                  1,
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Pinput(
                  defaultPinTheme: defaultPinTheme,
                  errorPinTheme: errorPinTheme,
                  errorBuilder: (context, error) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Passcodes do not match",
                          style: TextStyle(
                            color: errorColor,
                            fontWeight: FontWeight.w500,
                            fontSize: FetchPixels.getPixelHeight(13),
                          ),
                        ),
                      ),
                    );
                  },
                  forceErrorState: _forceErrorState, // Apply the error state
                  errorText: "Incorrect PIN",
                  length: 4,
                  obscureText: true,
                  focusNode: myFocusNode,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: false, // Disable the cursor
                  readOnly: true, // Make the field read-only
                  controller: _pinController, // Update the Pinput value
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              NumericKeyboard(
                  onKeyboardTap: _onKeyboardTap,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                      color: grey700,
                      fontFamily: Constant.fontsFamily),
                  rightButtonFn: () {
                    if (text.isEmpty) return;
                    setState(() {
                      text = text.substring(0, text.length - 1);
                      _pinController.text = text;
                    });
                  },
                  rightButtonLongPressFn: () {
                    if (text.isEmpty) return;
                    setState(() {
                      text = '';
                      _pinController.clear();
                    });
                  },
                  rightIcon:
                      getSvgImage("back_arrow.svg", width: 20, height: 20),
                  leftButtonFn: () {
                    debugPrint('left button clicked');
                  },
                  leftIcon: Container(),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createPasscode() async {
    await ref.read(signUpControllerProvider).createPasscode(
          context: context,
          confirmPasscode: confirmPasscode,
          newPasscode: newPasscode,
        );
  }
}
