import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:tampay_mobile/app/view/home/cards/domain/model/request/create_card_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/request/initiate_transfer_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/account_info_response.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/banks_response.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/recent_transactions_response.dart';
import '../../../../base/failure.dart';
import '../../../../base/resizer/error_handler.dart';
import '../domain/model/request/transfer_request.dart';
import '../domain/repository/transactions_repository.dart';

// Define a provider for the TransactionsService
final transactionsServiceProvider = Provider<TransactionsService>((ref) {
  return TransactionsServiceImpl(
    ref.read(transactionsRepositoryProvider), // Pass the TransactionsRepository
    ref, // Pass the Ref
  );
});

// Abstract TransactionsService class
abstract class TransactionsService {
  Future<RecentTransactionsResponse> getRecentTransactions();
  Future<BanksResponse> getBanks();
  Future createCard(CreateCardRequest createCardRequest);
  Future initiateTransferRequest(
      InitiateTransferRequest initiateTransferRequest);
  Future transferRequest(TransferRequest transferRequest);
  Future<AccountInfoResponse> getAccountInfo(String bankCode, String accountNo);
}

// Implementation of TransactionsService
class TransactionsServiceImpl implements TransactionsService {
  final TransactionsRepository _transactionsRepository;
  final Ref ref;
  TransactionsServiceImpl(this._transactionsRepository, this.ref);

  // Implement the getTransactions method
  @override
  Future<RecentTransactionsResponse> getRecentTransactions() async {
    try {
      // Call the service to get the Transactions
      final RecentTransactionsResponse recentTransactions =
          await _transactionsRepository.getRecentTransactions();
      // Return the fetched Transactions
      return recentTransactions;
    } catch (e) {
      // Handle errors by logging and throwing a custom exception
      debugPrint('Error getting Transactions: $e');
      throw Exception('Failed to load Transactions');
    }
  }

  @override
  Future<BanksResponse> getBanks() async {
    try {
      // Call the service to get the Transactions
      final BanksResponse banksResponse =
          await _transactionsRepository.getBanks();
      // Return the fetched Transactions
      return banksResponse;
    } catch (e) {
      // Handle errors by logging and throwing a custom exception
      debugPrint('Error getting Banks: $e');
      throw Exception('Failed to load Banks');
    }
  }

  @override
  Future<AccountInfoResponse> getAccountInfo(
      String bankCode, String accountNo) async {
    try {
      // Call the service to get the Transactions
      final AccountInfoResponse accountInfoResponse =
          await _transactionsRepository.getAccountInfo(bankCode, accountNo);
      // Return the fetched Transactions
      return accountInfoResponse;
    } catch (e) {
      // Handle errors by logging and throwing a custom exception
      debugPrint('Error getting account info: $e');
      throw Exception('Error getting account info:');
    }
  }

  @override
  Future<Result<Map<String, dynamic>, Failure>> initiateTransferRequest(
      InitiateTransferRequest initiateTransferRequest) async {
    try {
      final response = await ref
          .read(transactionsRepositoryProvider)
          .initiateTransfer(initiateTransferRequest);
      return Success(response ?? {});
    } catch (error) {
      // Use the ErrorHandler to process the error
      final errorMessage = ErrorHandler.getErrorMessage(error);
      return Error(Failure(message: errorMessage));
    }
  }

  @override
  Future<Result<Map<String, dynamic>, Failure>> transferRequest(
      TransferRequest transferRequest) async {
    try {
      final response = await ref
          .read(transactionsRepositoryProvider)
          .transfer(transferRequest);
      return Success(response ?? {});
    } catch (error) {
      // Use the ErrorHandler to process the error
      final errorMessage = ErrorHandler.getErrorMessage(error);
      return Error(Failure(message: errorMessage));
    }
  }

  @override
  Future createCard(CreateCardRequest createCardRequest) async {
    try {
      final response = await ref
          .read(transactionsRepositoryProvider)
          .createCard(createCardRequest);
      return Success(response ?? {});
    } catch (error) {
      // Use the ErrorHandler to process the error
      final errorMessage = ErrorHandler.getErrorMessage(error);
      return Error(Failure(message: errorMessage));
    }
  }
}
