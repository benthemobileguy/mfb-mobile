import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/env/env.dart';
import 'package:tampay_mobile/app/view/home/send/recent_transations.dart';
import 'package:tampay_mobile/app/view/transactions/domain/repository/transactions_repository.dart';
import 'package:tampay_mobile/base/dio_provider.dart';
import '../client/transactions_api_client.dart';

final transactionsRepositoryProvider = Provider<TransactionsRepository>((ref) {
  return TransactionsRepositoryImpl(TransactionsApiClient(
      baseUrl: ref.read(dioProvider).options.baseUrl, ref.read(dioProvider)));
});

class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsApiClient _transactionsClient;

  TransactionsRepositoryImpl(this._transactionsClient);

  @override
  Future<RecentTransactions> getRecentTransactions() async {
    try {
      final loginResponse = await _transactionsClient.recentTransactions(
          Env.accessKey, Env.secretKey);
      return loginResponse;
    } on DioException catch (e) {
      debugPrint('DioException caught: $e');
      // Rethrow the exception so it can be caught by the AuthService
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Login failed: $e');
    }
  }
}
