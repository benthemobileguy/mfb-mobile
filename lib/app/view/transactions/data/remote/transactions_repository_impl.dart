import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/env/env.dart';
import 'package:tampay_mobile/app/view/home/cards/domain/model/request/create_card_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/request/fund_card_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/request/initiate_transfer_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/request/transfer_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/account_info_response.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/banks_response.dart';
import 'package:tampay_mobile/app/view/transactions/domain/repository/transactions_repository.dart';
import 'package:tampay_mobile/base/dio_provider.dart';
import '../../../../../main.dart';
import '../../../../../manager/auth_manager.dart';
import '../../domain/model/response/recent_transactions_response.dart';
import '../client/transactions_api_client.dart';

final transactionsRepositoryProvider = Provider<TransactionsRepository>((ref) {
  return TransactionsRepositoryImpl(TransactionsApiClient(
      baseUrl: ref.read(dioProvider).options.baseUrl, ref.read(dioProvider)));
});

class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsApiClient _transactionsClient;

  TransactionsRepositoryImpl(this._transactionsClient);

  @override
  Future<RecentTransactionsResponse> getRecentTransactions() async {
    try {
      final response = await _transactionsClient.recentTransactions(
        "Bearer ${getIt<AuthManager>().token!}",
        Env.accessKey,
        Env.secretKey,
      );
      return RecentTransactionsResponse.fromJson(response);
    } on DioException catch (e) {
      debugPrint('DioException caught: $e');
      // Rethrow the exception so it can be caught by the AuthService
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Fetching transactions failed: $e');
    }
  }

  @override
  Future<BanksResponse> getBanks() async {
    try {
      final response = await _transactionsClient.banks(
        "Bearer ${getIt<AuthManager>().token!}",
        Env.accessKey,
        Env.secretKey,
      );
      return BanksResponse.fromJson(response);
    } on DioException catch (e) {
      debugPrint('DioException caught: $e');
      // Rethrow the exception so it can be caught by the AuthService
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Fetching banks failed: $e');
    }
  }

  @override
  Future<AccountInfoResponse> getAccountInfo(
      String bankCode, String accountNo) async {
    try {
      final response = await _transactionsClient.accountInfo(
          "Bearer ${getIt<AuthManager>().token!}",
          Env.accessKey,
          Env.secretKey,
          bankCode,
          accountNo);
      return AccountInfoResponse.fromJson(response);
    } on DioException catch (e) {
      debugPrint('DioException caught: $e');
      // Rethrow the exception so it can be caught by the AuthService
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Fetching banks failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> initiateTransfer(
      InitiateTransferRequest? initiateTransferRequest) async {
    try {
      final initiateTransferResponse =
          await _transactionsClient.initiateTransfer(
              "Bearer ${getIt<AuthManager>().token!}",
              Env.accessKey,
              Env.secretKey,
              "idempotent-key1",
              initiateTransferRequest!);
      return initiateTransferResponse;
    } on DioException catch (e) {
      debugPrint('DioException caught: $e');
      // Rethrow the exception so it can be caught by the AuthService
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Initiate transaction failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> transfer(
      TransferRequest? transferRequest) async {
    try {
      final transferResponse = await _transactionsClient.transfer(
          "Bearer ${getIt<AuthManager>().token!}",
          Env.accessKey,
          Env.secretKey,
          transferRequest!);
      return transferResponse;
    } on DioException catch (e) {
      debugPrint('DioException caught: $e');
      // Rethrow the exception so it can be caught by the AuthService
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Transfer failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> createCard(
      CreateCardRequest? createCardRequest) async {
    try {
      final transferResponse = await _transactionsClient.createCard(
          "Bearer ${getIt<AuthManager>().token!}",
          Env.accessKey,
          Env.secretKey,
          createCardRequest!);
      return transferResponse;
    } on DioException catch (e) {
      debugPrint('DioException caught: $e');
      // Rethrow the exception so it can be caught by the AuthService
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Transfer failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> fundCard(
      FundCardRequest? fundCardRequest, ) async {
    try {
      final transferResponse = await _transactionsClient.fundCard(
          "Bearer ${getIt<AuthManager>().token!}",
          Env.accessKey,
          Env.secretKey,
          fundCardRequest!, "");
      return transferResponse;
    } on DioException catch (e) {
      debugPrint('DioException caught: $e');
      // Rethrow the exception so it can be caught by the AuthService
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Transfer failed: $e');
    }
  }
}
