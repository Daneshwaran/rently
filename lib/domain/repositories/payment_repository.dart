import '../entities/payment.dart';

abstract class PaymentRepository {
  Future<Payment> createPayment(Payment payment);
  Future<List<Payment>> getAllPayments();
  Future<List<Payment>> getPaymentsByHouseId(String houseId);
  Future<List<Payment>> getPaymentsByTenantId(String tenantId);
  Future<Payment?> getPaymentById(String id);
  Future<Payment> updatePayment(Payment payment);
  Future<void> deletePayment(String id);
}
