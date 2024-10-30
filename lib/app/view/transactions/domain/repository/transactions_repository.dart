import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/view/home/cards/domain/model/request/create_card_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/request/fund_card_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/request/initiate_transfer_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/request/transfer_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/account_info_response.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/banks_response.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/response/recent_transactions_response.dart';
import '../../../../../base/dio_provider.dart';
import '../../data/client/transactions_api_client.dart';
import '../../data/remote/transactions_repository_impl.dart';

final transactionsRepositoryProvider = Provider<TransactionsRepository>((ref) {
  return TransactionsRepositoryImpl(TransactionsApiClient(
    baseUrl: ref.read(dioProvider).options.baseUrl,
    ref.read(dioProvider),
  ));
});

abstract class TransactionsRepository {
  Future<RecentTransactionsResponse> getRecentTransactions();
  Future<BanksResponse> getBanks();
  Future<Map<String, dynamic>?> initiateTransfer(
      InitiateTransferRequest? initiateTransferRequest);
  Future<Map<String, dynamic>?> transfer(TransferRequest? transferRequest);
  Future<AccountInfoResponse> getAccountInfo(String bankCode, String accountNo);
  Future<Map<String, dynamic>?> createCard(
      CreateCardRequest? createCardRequest);
  Future<Map<String, dynamic>?> fundCard(
      FundCardRequest? createCardRequest); 
          
}
