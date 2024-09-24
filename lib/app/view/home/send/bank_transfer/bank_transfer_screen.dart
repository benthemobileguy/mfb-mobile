import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:tampay_mobile/app/view/transactions/presentation/controller/transactions_controller.dart';
import 'package:tampay_mobile/theme/color_data.dart';
import '../../../../../base/constant.dart';
import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../transactions/domain/model/response/banks_response.dart';
import 'controller/transfer_form_controller.dart';

class BankTransferScreen extends ConsumerStatefulWidget {
  const BankTransferScreen({super.key});

  @override
  ConsumerState<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends ConsumerState<BankTransferScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController bankController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController narrationController = TextEditingController();

  // State variable to hold the amount entered by the user
  String _enteredAmount = "0.00";
  String? selectedBankCode; // Variable to hold the selected bank code

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bankTransferFormControllerProvider.notifier).resetForm();
      // Initialize controllers with initial values
      final formState = ref.read(bankTransferFormControllerProvider);
      bankController.text = formState.bank;
      accountNoController.text = formState.accountNumber;
      narrationController.text = formState.narration;

      // Add listeners to update state when text changes
      bankController.addListener(() {
        ref
            .read(bankTransferFormControllerProvider.notifier)
            .updateBank(bankController.text);
      });

      accountNoController.addListener(() {
        ref
            .read(bankTransferFormControllerProvider.notifier)
            .updateAccountNumber(accountNoController.text);
      });

      narrationController.addListener(() {
        ref
            .read(bankTransferFormControllerProvider.notifier)
            .updateNarration(narrationController.text);
      });
    });
  }

  @override
  void dispose() {
    // Dispose controllers and other resources
    _tabController.dispose();
    bankController.dispose();
    accountNoController.dispose();
    narrationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(bankTransferFormControllerProvider);
    bool isFormValid = formState.isBankValid &&
        formState.isAccountNumberValid &&
        formState.isAmountValid;

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
              accountBalance(context, ref),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              GestureDetector(
                onTap: () => _showAmountInput(context, formState.balance,
                    (updatedAmount) {
                  // Update the state in the parent widget when the amount is changed
                  setState(() {
                    _enteredAmount = updatedAmount;
                  });
                }),
                child: amountInput(context),
              ),
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
                            InkWell(
                              onTap: () {
                                _showBanksInModal(context);
                              },
                              child: getDefaultTextFiledWithLabel(
                                context,
                                "Select Bank",
                                title: "Bank",
                                bankController,
                                height: FetchPixels.getPixelHeight(60),
                                withSuffix: true,
                                showCursor: false,
                                suffixImageHeight: 12,
                                suffixImageWidth: 12,
                                suffixImage: "chevron_down_dark.svg",
                                isEnable: false,
                              ),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(20)),
                            getDefaultTextFiledWithLabel(
                              context,
                              "Enter Account Number",
                              title: "Account Number",
                              accountNoController,
                              height: FetchPixels.getPixelHeight(60),
                              isEnable: true, // Enable the field
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
                              isEnable: true, // Enable the field
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          getSvgImage("user_group.svg", width: 24, height: 24),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          getCustomFont("No Beneficiaries", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          getCustomFont(
                              "The beneficiaries you add will show up here",
                              13,
                              grey650,
                              1,
                              fontWeight: FontWeight.w400),
                          getVerSpace(FetchPixels.getPixelHeight(30)),
                          SizedBox(
                            height: 44,
                            width: 230,
                            child: getButton(context, Colors.white,
                                "Add Beneficiaries", primaryColor, () {
                              showComingSoonDialog(context);
                            }, 14,
                                borderColor: primaryColor,
                                isBorder: true,
                                isIcon: true,
                                borderWidth: 0,
                                image: "plus.svg",
                                weight: FontWeight.w600,
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(15)),
                                buttonHeight: FetchPixels.getPixelHeight(60)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              getButton(
                context,
                isFormValid ? primaryColor : greyColor300,
                "Send",
                Colors.white,
                isFormValid
                    ? () async {
                        ref
                            .read(transactionsControllerProvider.notifier)
                            .setSelectedAmount(_enteredAmount);
                        ref
                            .read(transactionsControllerProvider.notifier)
                            .setNarration(narrationController.text);
                        // Pass selectedBankCode and accountNoController.text to getAccountInfo
                        await ref
                            .read(transactionsControllerProvider)
                            .getAccountInfo(
                              context,
                              selectedBankCode ?? "",
                              accountNoController.text.trim(),
                            );
                      }
                    : null, // Disable button if conditions aren't met
                16,
                weight: FontWeight.w600,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60),
              ),
              getVerSpace(FetchPixels.getPixelHeight(30)),
            ],
          ),
        ),
      ),
    );
  }

  // Method to show amount input using NumericKeyboard
  void _showAmountInput(BuildContext context, double maxBalance,
      Function(String) onAmountEntered) {
    String amountText = "";
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: getCustomFont("Enter Amount", 15, h6, 1,
                  fontWeight: FontWeight.w600),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: amountController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "0.00",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                        color: grey700,
                        fontFamily: Constant.fontsFamily,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  NumericKeyboard(
                    onKeyboardTap: (value) {
                      setState(() {
                        if (amountText.length < 10) {
                          amountText += value;
                          amountController.text = amountText;
                        }
                      });
                    },
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                      color: grey700,
                      fontFamily: Constant.fontsFamily,
                    ),
                    rightButtonFn: () {
                      if (amountText.isNotEmpty) {
                        setState(() {
                          amountText =
                              amountText.substring(0, amountText.length - 1);
                          amountController.text = amountText;
                        });
                      }
                    },
                    rightIcon:
                        getSvgImage("back_arrow.svg", width: 20, height: 20),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    double enteredAmount = double.tryParse(amountText) ?? 0;

                    // Validation happens here when Done button is pressed
                    if (enteredAmount > maxBalance) {
                      // Show alert if amount is greater than balance
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: getCustomFont("Invalid Amount", 15, h6, 1,
                                fontWeight: FontWeight.w600),
                            content: getCustomFont(
                                "The amount cannot be greater than your account balance.",
                                13,
                                grey650,
                                3,
                                fontWeight: FontWeight.w400),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: getCustomFont("OK", 15, h6, 1,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Format the amount to ensure ".00" is appended if necessary
                      String formattedAmount = enteredAmount.toStringAsFixed(2);

                      // Update the form state with the validated amount
                      ref
                          .read(bankTransferFormControllerProvider.notifier)
                          .updateAmount(enteredAmount, maxBalance);

                      // Pass the formatted amount back to the parent widget
                      onAmountEntered(formattedAmount);
                      Navigator.of(context).pop();
                    }
                  },
                  child: getCustomFont("Done", 15, h6, 1,
                      fontWeight: FontWeight.w600),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showBanksInModal(BuildContext context) async {
    final banks =
        await ref.read(transactionsControllerProvider).banksList?.data;

    if (banks == null) {
      // Handle the case where banks are null
      showErrorToast(context, 'No banks available');
      return;
    }

    // TextEditingController for search input
    TextEditingController searchController = TextEditingController();
    // Create a state variable to hold the filtered list of banks
    List<Banks> filteredBanks = banks;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Function to filter banks based on the search input
            void filterBanks(String query) {
              setState(() {
                if (query.isEmpty) {
                  filteredBanks = banks; // Show all banks if search is empty
                } else {
                  filteredBanks = banks
                      .where((bank) =>
                          bank.bank
                              ?.toLowerCase()
                              .contains(query.toLowerCase()) ??
                          false)
                      .toList();
                }
              });
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.90,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    dragIndicator(context),
                    const SizedBox(height: 20),
                    // Search widget for filtering banks
                    getSearchWidget(
                      context,
                      searchController,
                      "Search Banks",
                      true,
                      () {}, // Functionality when clicking on the search input
                      (value) => filterBanks(
                          value), // Call filterBanks on input change
                      withPrefix: true,
                    ),
                    // List of filtered banks
                    Expanded(
                      child: filteredBanks.isNotEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              itemCount: filteredBanks.length,
                              itemBuilder: (context, index) {
                                final bank = filteredBanks[index];
                                return ListTile(
                                  title: getCustomFont(
                                      bank.bank ?? "", 14, grey800, 1,
                                      fontWeight: FontWeight.w500),
                                  onTap: () {
                                    // Update the bank field with the selected bank and its code
                                    bankController.text = bank.bank ?? "";
                                    selectedBankCode = bank
                                        .code; // Store the selected bank code
                                    ref
                                        .read(bankTransferFormControllerProvider
                                            .notifier)
                                        .updateBank(bank.bank ?? "");
                                    Navigator.pop(context); // Close the modal
                                  },
                                );
                              },
                            )
                          : Center(
                              child: getCustomFont(
                                  "No banks available", 15, h6, 1,
                                  fontWeight: FontWeight.w600),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Updated amountInput widget to use _enteredAmount state variable
  Widget amountInput(BuildContext context,
      {Color borderColor = Colors.transparent}) {
    return Column(
      children: [
        Center(
          child: getCustomFont("ENTER AMOUNT", 12.5, grey650, 1,
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
              _enteredAmount,
              40,
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
}
