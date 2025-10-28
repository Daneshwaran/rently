import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/payment.dart';
import 'payment_repository_provider.dart';

final paymentListProvider = FutureProvider<List<Payment>>((ref) async {
  final repository = ref.read(paymentRepositoryProvider);
  return await repository.getAllPayments();
});

final paymentsByHouseProvider = FutureProvider.family<List<Payment>, String>((
  ref,
  houseId,
) async {
  final repository = ref.read(paymentRepositoryProvider);
  return await repository.getPaymentsByHouseId(houseId);
});

final paymentsByTenantProvider = FutureProvider.family<List<Payment>, String>((
  ref,
  tenantId,
) async {
  final repository = ref.read(paymentRepositoryProvider);
  return await repository.getPaymentsByTenantId(tenantId);
});

final createPaymentProvider =
    StateNotifierProvider<CreatePaymentNotifier, AsyncValue<void>>((ref) {
      return CreatePaymentNotifier(ref.read(paymentRepositoryProvider));
    });

class CreatePaymentNotifier extends StateNotifier<AsyncValue<void>> {
  final paymentRepository;

  CreatePaymentNotifier(this.paymentRepository)
    : super(const AsyncValue.data(null));

  Future<void> createPayment(Payment payment) async {
    state = const AsyncValue.loading();
    try {
      await paymentRepository.createPayment(payment);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final updatePaymentProvider =
    StateNotifierProvider<UpdatePaymentNotifier, AsyncValue<void>>((ref) {
      return UpdatePaymentNotifier(ref.read(paymentRepositoryProvider));
    });

class UpdatePaymentNotifier extends StateNotifier<AsyncValue<void>> {
  final paymentRepository;

  UpdatePaymentNotifier(this.paymentRepository)
    : super(const AsyncValue.data(null));

  Future<void> updatePayment(Payment payment) async {
    state = const AsyncValue.loading();
    try {
      await paymentRepository.updatePayment(payment);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final deletePaymentProvider =
    StateNotifierProvider<DeletePaymentNotifier, AsyncValue<void>>((ref) {
      return DeletePaymentNotifier(ref.read(paymentRepositoryProvider));
    });

class DeletePaymentNotifier extends StateNotifier<AsyncValue<void>> {
  final paymentRepository;

  DeletePaymentNotifier(this.paymentRepository)
    : super(const AsyncValue.data(null));

  Future<void> deletePayment(String paymentId) async {
    state = const AsyncValue.loading();
    try {
      await paymentRepository.deletePayment(paymentId);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
