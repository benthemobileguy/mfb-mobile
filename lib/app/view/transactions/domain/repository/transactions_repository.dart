import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/view/home/send/recent_transations.dart';
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
  Future<RecentTransactions> getRecentTransactions();
}
