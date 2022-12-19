
import 'package:cryptotest/repositories/crypto_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coinListProvider = FutureProvider((ref) {
  final cryptoRepository = ref.watch(cryptoRepositoryProvider);
  return cryptoRepository.getCoinPrices();
});

final dollarRateProvider = FutureProvider((ref) {
  final cryptoRepository = ref.watch(cryptoRepositoryProvider);
  return cryptoRepository.getDollarConversionRate();
});
