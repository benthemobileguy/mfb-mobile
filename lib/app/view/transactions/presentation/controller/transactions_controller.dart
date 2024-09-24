import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/request/initiate_transfer_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/request/transfer_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/account_info_response.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/banks_response.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/initiate_transfer_response.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/recent_transactions_response.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/transfer_response.dart';
import '../../../../../base/constant.dart';
import '../../../../../base/custom_progess_dialog.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../profile/presentation/controller/profile_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../services/transaction_service.dart';

final transactionsControllerProvider =
    ChangeNotifierProvider<TransactionsController>((ref) {
  return TransactionsController(ref);
});

class TransactionsController extends ChangeNotifier {
  final Ref ref;
  RecentTransactionsResponse? recentTransactionsList;
  InitiateTransferResponse? initiateTransferResponse;
  TransferResponse? transferResponse;
  BanksResponse? banksList;
  AccountInfoResponse? accountInfoResponse;

  // Add properties to store selected bank code, account number, and amount
  String selectedAmount = "0.00";
  String selectedAccountName = "";
  String selectedBankCode = "";
  String narration = "";

  TransactionsController(this.ref);

  // Method to update the selected amount
  void setSelectedAmount(String amount) {
    selectedAmount = amount;
    notifyListeners();
  }

  // Method to update the narration
  void setNarration(String narr) {
    narration = narr;
    notifyListeners();
  }

  // Method to update the selected account information
  void setAccountInfo(AccountInfoResponse response) {
    accountInfoResponse = response;
    selectedAccountName = response.data?.accountName ?? "Unknown";
    notifyListeners();
  }

  Future<BanksResponse?> getBanks() async {
    try {
      final response = await ref.read(transactionsServiceProvider).getBanks();
      banksList = response;
      notifyListeners();

      return banksList;
    } catch (e) {
      debugPrint("Error fetching account info: $e");
      return null;
    }
  }

  Future<RecentTransactionsResponse?> getRecentTransactions() async {
    try {
      final response =
          await ref.read(transactionsServiceProvider).getRecentTransactions();
      recentTransactionsList = response;
      // Ensure that the UI is notified about the updated profile
      notifyListeners();

      return recentTransactionsList;
    } catch (e) {
      debugPrint("Error fetching transactions list: $e");
      return null;
    }
  }

  Future<void> transfer(BuildContext context, String pin) async {
    try {
      // Show the progress dialog before making the request
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const CustomProgressDialog(),
      );

      // Initiate transfer request and handle the response correctly
      final responseInit = await ref
          .read(transactionsServiceProvider)
          .initiateTransferRequest(InitiateTransferRequest(
            wallet: "NGN",
            beneficiaryAccountNumber:
                accountInfoResponse?.data?.accountNumber ?? "",
            beneficiaryAccountName:
                accountInfoResponse?.data?.accountName ?? "",
            beneficiaryBankCode: accountInfoResponse?.data?.bankCode ?? "",
            enquiryId: accountInfoResponse?.data?.enquiryId ?? "",
            amount: selectedAmount,
            saveBeneficiary: true,
            narration: narration,
          ));

      // Check the result of the initiation request using the correct `when` syntax
      responseInit.when(
        (success) async {
          // Correctly handle the success case
          initiateTransferResponse = InitiateTransferResponse.fromJson(success);
          notifyListeners();

          // Proceed with the transfer request using the transfer ID from the successful initiation
          final response = await ref
              .read(transactionsServiceProvider)
              .transferRequest(TransferRequest(
                wallet: "NGN",
                beneficiaryAccountNumber:
                    accountInfoResponse?.data?.accountNumber ?? "",
                amount: selectedAmount,
                narration: "Transfer",
                transferId: initiateTransferResponse?.data?.id ?? "",
                beneficiaryBankCode: accountInfoResponse?.data?.bankCode ?? "",
                transactionPin: pin,
              ));

          // Handle the transfer request response
          response.when(
            (success) async {
              transferResponse = TransferResponse.fromJson(success);
              notifyListeners();
              Constant.sendToReplacementNext(
                  context, Routes.transactionSuccessfulRoute);
              await ref.read(profileControllerProvider).getProfile();
            },
            (error) {
              // Dismiss the dialog and show error message
              Navigator.of(context, rootNavigator: true).pop();
              showErrorToast(context, error.message);
            },
          );
        },
        (error) {
          // Handle initiation error
          Navigator.of(context, rootNavigator: true).pop();
          showErrorToast(context, error.message);
        },
      );
    } catch (e) {
      print(e.toString());
      // Handle the unexpected error
      showErrorToast(
          context, 'An unexpected error occurred. Please try again.');
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<AccountInfoResponse?> getAccountInfo(
      BuildContext context, String bankCode, String accountNo) async {
    // Show the progress dialog before making the request
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    try {
      // Attempt to get the account information
      final response = await ref
          .read(transactionsServiceProvider)
          .getAccountInfo(bankCode, accountNo);

      // If the response is successful, handle success
      setAccountInfo(response);

      // Dismiss the progress dialog and then navigate to the next route
      Navigator.of(context, rootNavigator: true).pop();
      await Future.delayed(const Duration(
          milliseconds:
              100)); // Slight delay to ensure the dialog is fully dismissed
      Navigator.pushReplacementNamed(
          context, Routes.sendMoneyConfirmationRoute);

      return accountInfoResponse;
    } catch (e) {
      // Handle the error by showing a toast
      showErrorToast(
          context, 'An unexpected error occurred. Please try again.');

      // Dismiss the progress dialog in case of an error
      Navigator.of(context, rootNavigator: true).pop();
    }

    return null;
  }
}
