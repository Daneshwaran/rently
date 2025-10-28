import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/repositories/payment_repository_impl.dart';
import '../../domain/repositories/payment_repository.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepositoryImpl();
});
