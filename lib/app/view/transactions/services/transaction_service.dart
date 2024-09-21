import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/view/home/send/recent_transations.dart';
import '../domain/repository/transactions_repository.dart';

// Define a provider for the TransactionsService
final transactionsServiceProvider = Provider<TransactionsService>((ref) {
  return TransactionsServiceImpl(ref
      .read(transactionsRepositoryProvider)); // Pass the reader method from Ref
});

// Abstract TransactionsService class
abstract class TransactionsService {
  Future<RecentTransactions> getRecentTransactions();
}

// Implementation of TransactionsService
class TransactionsServiceImpl implements TransactionsService {
  final TransactionsRepository _transactionsRepository;
  TransactionsServiceImpl(this._transactionsRepository);

  // Implement the getTransactions method
  @override
  Future<RecentTransactions> getRecentTransactions() async {
    try {
      // Call the service to get the Transactions
      final RecentTransactions recentTransactions =
          await _transactionsRepository.getRecentTransactions();
      // Return the fetched Transactions
      return recentTransactions;
    } catch (e) {
      // Handle errors by logging and throwing a custom exception
      debugPrint('Error getting Transactions: $e');
      throw Exception('Failed to load Transactions');
    }
  }
}
