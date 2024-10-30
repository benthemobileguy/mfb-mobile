// currency_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCurrencyProvider = StateProvider<String?>((ref) => null);
final isFeeAcceptedProvider = StateProvider<bool>((ref) => false);
