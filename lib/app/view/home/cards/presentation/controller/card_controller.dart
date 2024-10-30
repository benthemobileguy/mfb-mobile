// currency_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCurrencyProvider = StateProvider<String?>((ref) => "USD");
final isFeeAcceptedProvider = StateProvider<bool>((ref) => true);
