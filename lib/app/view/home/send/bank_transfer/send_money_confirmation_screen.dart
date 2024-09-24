import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import '../../../../../base/constant.dart';
import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../../theme/color_data.dart';
import '../../../transactions/presentation/controller/transactions_controller.dart';

class SendMoneyConfirmationScreen extends ConsumerStatefulWidget {
  const SendMoneyConfirmationScreen({super.key});

  @override
  ConsumerState<SendMoneyConfirmationScreen> createState() =>
      _SendMoneyConfirmationScreenState();
}

class _SendMoneyConfirmationScreenState
    extends ConsumerState<SendMoneyConfirmationScreen> {
  FocusNode myFocusNode = FocusNode();
  Color color = greyColor300;

  // State to hold the entered PIN and button state
  String _enteredPin = '';
  bool _isSendButtonEnabled = false;

  void finishView() {
    Constant.backToPrev(context);
  }

  // Method to handle PIN input changes
  void _onPinChanged(String pin) {
    setState(() {
      _enteredPin = pin;
      _isSendButtonEnabled = pin.length == 4; // Enable button if 4 characters
    });
  }

  // Method to handle Send button click
  void _onSendPressed() async {
    if (_isSendButtonEnabled) {
      await ref
          .read(transactionsControllerProvider)
          .transfer(context, _enteredPin);
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionsController = ref.watch(transactionsControllerProvider);
    final amount = transactionsController.selectedAmount;
    final accountName = transactionsController.selectedAccountName;
    final bankName =
        transactionsController.accountInfoResponse?.data?.bankName ??
            "Unknown Bank";

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
        border: Border.all(
          color: greyColor300,
          width: FetchPixels.getPixelHeight(1),
        ),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButtonWidget("back.svg", context: context),
              getVerSpace(20),
              Center(
                child: getCustomFont(
                  "You’re About to send",
                  16,
                  grey700,
                  1,
                  fontWeight: FontWeight.normal,
                ),
              ),
              getVerSpace(10),
              currencyAmount(context, amount),
              getVerSpace(10),
              recipientDetails(context, accountName),
              getVerSpace(50),
              Center(
                child: getCustomFont(
                  "Enter Pin to Confirm Transaction",
                  16,
                  grey650,
                  1,
                  fontWeight: FontWeight.normal,
                ),
              ),
              getVerSpace(15),
              Center(
                child: Focus(
                  onFocusChange: (hasFocus) {
                    if (hasFocus) {
                      setState(() {
                        color = greyColor300;
                        myFocusNode.canRequestFocus = true;
                      });
                    } else {
                      setState(() {
                        color = borderColor;
                        myFocusNode.canRequestFocus = false;
                      });
                    }
                  },
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    cursor: Container(),
                    length: 4,
                    focusNode: myFocusNode,
                    showCursor: true,
                    mainAxisAlignment: MainAxisAlignment.center,
                    onChanged: _onPinChanged, // Update button state on input
                  ),
                ),
              ),
              const Spacer(),
              getButton(
                context,
                _isSendButtonEnabled
                    ? primaryColor
                    : greyColor300, // Button color based on state
                "Send",
                Colors.white,
                _isSendButtonEnabled
                    ? _onSendPressed
                    : null, // Enable or disable button
                16,
                weight: FontWeight.w600,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60),
              ),
              getVerSpace(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget currencyAmount(BuildContext context, String amount) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: getCustomFont(
            "₦",
            38,
            Colors.black,
            1,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
          ),
        ),
        getCustomFont(
          amount,
          38,
          Colors.black,
          1,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget recipientDetails(BuildContext context, String accountName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getCustomFont(
          "To",
          16,
          Colors.black,
          1,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
        ),
        getHorSpace(6),
        getPngImage("kuda.png", height: 30, width: 30),
        getHorSpace(6),
        getCustomFont(
          accountName,
          14.5,
          Colors.black,
          1,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
        ),
      ],
    );
  }
}
