import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/profile/domain/model/response/user_profile.dart';
import 'package:tampay_mobile/app/profile/presentation/controller/profile_controller.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class ConvertScreen extends ConsumerStatefulWidget {
  const ConvertScreen({super.key});

  @override
  ConsumerState<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends ConsumerState<ConvertScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController convertedAmountController = TextEditingController();
  double usdToNgnRate = 1700.0; // USD to NGN
  double eurToNgnRate = 1778.0; // EUR to NGN
  double conversionFee = 0.2;
  double totalCharge = 0.0;

  String selectedCurrency = "GBP";
  String selectedConvertedCurrency = "NGN"; // Separate state for second field

  // Currency logo and symbol mapping
  final Map<String, String> currencyLogos = {
    "EUR": "euro_sign.svg",
    "NGN": "ngn_logo.svg",
    "USD": "usd_logo.svg",
    "GBP": "britain_logo.svg",
  };

  final Map<String, String> currencySymbols = {
    "EUR": "€",
    "NGN": "NGN",
    "USD": "\$",
    "GBP": "£",
  };

  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileControllerProvider);
    final profile = profileController.userProfile;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context, ""),
              getVerSpace(16),
              getCustomFont("Fund Account", 22, grey700, 1,
                  fontWeight: FontWeight.w600),
              getVerSpace(5),
              getCustomFont(
                "Fund your virtual account from your Naira account",
                14.5,
                grey700,
                1,
                fontWeight: FontWeight.normal,
              ),
              getVerSpace(25),
              _buildAmountField(context),
              getVerSpace(10),
              getCustomFont(
                  "Balance: ${currencySymbols[selectedCurrency] ?? ''}${_getWalletBalance(profile)}",
                  14.5,
                  grey650,
                  1,
                  fontWeight: FontWeight.normal),
              getVerSpace(30),
              _buildConversionInfoContainer(),
              getVerSpace(30),
              _buildConvertedAmountField(context),
              const Spacer(),
              getButton(
                context,
                amountController.text.isEmpty ? greyColor300 : primaryColor,
                "Fund Account",
                Colors.white,
                   amountController.text.isNotEmpty
                    ? () {

                    }
                    : null,
                //amountController.text.isNotEmpty
                //    ? () => Constant.sendToNext(
                //          context,
                //          Routes.conversionSuccessRoute,
                //        )
                //    : null,
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

  double _getWalletBalance(UserProfile? profile) {
    final wallet = profile?.data?.wallets?.firstWhere(
        (wallet) => wallet.currency == selectedCurrency,
        orElse: () => Wallet());

    return double.tryParse(wallet?.balance ?? '0') ?? 0.0;
  }

  Widget _buildAmountField(BuildContext context) {
    return InkWell(
      onTap: () => _showCurrencySelectionSheet(
          context, true), // Pass true for amount field
      child: getDefaultTextFiledWithLabel(
        context,
        "${currencySymbols[selectedCurrency] ?? ''}0.00",
        amountController,
        title: "Enter Amount",
        withPrefix: true,
        image: currencyLogos[selectedCurrency] ?? "britain_logo.svg",
        height: FetchPixels.getPixelHeight(60),
        onChanged: (value) => _calculateConversion(),
      ),
    );
  }

  Widget _buildConvertedAmountField(BuildContext context) {
    return InkWell(
      onTap: () => _showCurrencySelectionSheet(
          context, false), // Pass false for converted field
      child: getDefaultTextFiledWithLabel(
        context,
        "${currencySymbols[selectedConvertedCurrency] ?? ''}0.00",
        convertedAmountController,
        title: "You'll get",
        withPrefix: true,
        image: currencyLogos[selectedConvertedCurrency] ?? "ngn_logo.svg",
        suffixImage: "chevron_down_grey.svg",
        isEnable: false,
        height: FetchPixels.getPixelHeight(60),
      ),
    );
  }

  Widget _buildConversionInfoContainer() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: grayColor,
        ),
        color: containerGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              getSvgImage("rate.svg", width: 20, height: 20),
              const Spacer(),
              getCustomFont(
                "${currencySymbols[selectedCurrency] ?? ''}1/${currencySymbols["NGN"] ?? ''}${_getConversionRate()}",
                14.5,
                grey700,
                1,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          getVerSpace(10),
          _buildConversionInfoRow("Conversion Fee",
              "-${currencySymbols["USD"] ?? ''}${conversionFee.toStringAsFixed(2)}"),
          Divider(color: greyColor300),
          getVerSpace(10),
          _buildConversionInfoRow("Total charge",
              "${currencySymbols["USD"] ?? ''}${totalCharge.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget _buildConversionInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getCustomFont(label, 14.5, grey700, 1, fontWeight: FontWeight.w500),
        getCustomFont(value, 14.5, grey700, 1, fontWeight: FontWeight.normal),
      ],
    );
  }

  double _getConversionRate() {
    if (selectedCurrency == "USD" && selectedConvertedCurrency == "NGN") {
      return usdToNgnRate;
    } else if (selectedCurrency == "EUR" &&
        selectedConvertedCurrency == "NGN") {
      return eurToNgnRate;
    } else if (selectedCurrency == "NGN" &&
        selectedConvertedCurrency == "USD") {
      return 1 / usdToNgnRate;
    } else if (selectedCurrency == "NGN" &&
        selectedConvertedCurrency == "EUR") {
      return 1 / eurToNgnRate;
    } else {
      return 1.0; // Default rate for unsupported pairs or same currency
    }
  }

  void _calculateConversion() {
    double amount = double.tryParse(amountController.text) ?? 0.0;
    double rate = _getConversionRate();
    setState(() {
      totalCharge = (amount * rate) - conversionFee;
      convertedAmountController.text =
          "${currencySymbols[selectedConvertedCurrency] ?? ''} ${totalCharge.toStringAsFixed(2)}";
    });
  }

  void _showCurrencySelectionSheet(BuildContext context, bool isAmountField) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            getCustomFont("Select Currency", 16.5, grey700, 1,
                fontWeight: FontWeight.bold),
            ..._buildCurrencyList(isAmountField),
          ],
        );
      },
    );
  }

  List<Widget> _buildCurrencyList(bool isAmountField) {
    final profile = ref.read(profileControllerProvider).userProfile;

    return profile?.data?.wallets?.map((wallet) {
          return ListTile(
            leading: getSvgImage(
              currencyLogos[wallet.currency] ?? "usd_logo.svg",
              width: 30,
              height: 30,
            ),
            title: getCustomFont(wallet.currency ?? '', 16, grey700, 1,
                fontWeight: FontWeight.bold),
            subtitle: getCustomFont(
                "Balance: ${wallet.balance}", 16.5, grey700, 1,
                fontWeight: FontWeight.normal),
            trailing: (isAmountField
                        ? selectedCurrency
                        : selectedConvertedCurrency) ==
                    wallet.currency
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: () {
              setState(() {
                if (isAmountField) {
                  selectedCurrency = wallet.currency!;
                } else {
                  selectedConvertedCurrency = wallet.currency!;
                }
              });
              Navigator.pop(context);
            },
          );
        }).toList() ??
        [];
  }
}
