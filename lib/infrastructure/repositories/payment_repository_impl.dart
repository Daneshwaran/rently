import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'payments';

  @override
  Future<Payment> createPayment(Payment payment) async {
    try {
      log('Creating payment: ${payment.id}');
      await _firestore
          .collection(_collectionName)
          .doc(payment.id)
          .set(payment.toJson());

      log('Payment saved to Firestore successfully with ID: ${payment.id}');
      return payment;
    } catch (e) {
      log('Error saving payment to Firestore: $e');
      throw Exception('Failed to save payment: $e');
    }
  }

  @override
  Future<List<Payment>> getAllPayments() async {
    try {
      log('Getting all payments from Firestore');
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .orderBy('paymentDate', descending: true)
          .get();

      final payments = querySnapshot.docs
          .map((doc) => Payment.fromJson(doc.data()))
          .toList();

      log('Total payments in Firestore: ${payments.length}');
      return payments;
    } catch (e) {
      log('Error getting all payments from Firestore: $e');
      throw Exception('Failed to get payments: $e');
    }
  }

  @override
  Future<List<Payment>> getPaymentsByHouseId(String houseId) async {
    try {
      log('Getting payments by house ID: $houseId');
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('houseId', isEqualTo: houseId)
          .orderBy('paymentDate', descending: true)
          .get();

      final payments = querySnapshot.docs
          .map((doc) => Payment.fromJson(doc.data()))
          .toList();

      log('Found ${payments.length} payments for house ID: $houseId');
      return payments;
    } catch (e) {
      log('Error getting payments by house ID: $e');
      throw Exception('Failed to get payments by house ID: $e');
    }
  }

  @override
  Future<List<Payment>> getPaymentsByTenantId(String tenantId) async {
    try {
      log('Getting payments by tenant ID: $tenantId');
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('tenantId', isEqualTo: tenantId)
          .orderBy('paymentDate', descending: true)
          .get();

      final payments = querySnapshot.docs
          .map((doc) => Payment.fromJson(doc.data()))
          .toList();

      log('Found ${payments.length} payments for tenant ID: $tenantId');
      return payments;
    } catch (e) {
      log('Error getting payments by tenant ID: $e');
      throw Exception('Failed to get payments by tenant ID: $e');
    }
  }

  @override
  Future<Payment?> getPaymentByHouseAndTenant(
    String houseId,
    String tenantId,
  ) async {
    try {
      log('Getting payment by house ID: $houseId and tenant ID: $tenantId');
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('houseId', isEqualTo: houseId)
          .where('tenantId', isEqualTo: tenantId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final payment = Payment.fromJson(querySnapshot.docs.first.data()!);
        log('Payment found: ${payment.id}');
        return payment;
      } else {
        log(
          'Payment not found with house ID: $houseId and tenant ID: $tenantId',
        );
        return null;
      }
    } catch (e) {
      log('Error getting payment by house ID: $e');
      throw Exception('Failed to get payment by house ID: $e');
    }
  }

  @override
  Future<Payment?> getPaymentById(String id) async {
    try {
      log('Getting payment by ID: $id');
      final docSnapshot = await _firestore
          .collection(_collectionName)
          .doc(id)
          .get();

      if (docSnapshot.exists) {
        final payment = Payment.fromJson(docSnapshot.data()!);
        log('Payment found: ${payment.id}');
        return payment;
      } else {
        log('Payment not found with ID: $id');
        return null;
      }
    } catch (e) {
      log('Error getting payment by ID: $e');
      throw Exception('Failed to get payment: $e');
    }
  }

  @override
  Future<Payment> updatePayment(Payment payment) async {
    try {
      log('Updating payment: ${payment.id}');
      await _firestore
          .collection(_collectionName)
          .doc(payment.id)
          .update(payment.toJson());

      log('Payment updated successfully in Firestore');
      return payment;
    } catch (e) {
      log('Error updating payment in Firestore: $e');
      throw Exception('Failed to update payment: $e');
    }
  }

  @override
  Future<void> deletePayment(String id) async {
    try {
      log('Deleting payment with ID: $id');
      await _firestore.collection(_collectionName).doc(id).delete();
      log('Payment deleted successfully from Firestore');
    } catch (e) {
      log('Error deleting payment from Firestore: $e');
      throw Exception('Failed to delete payment: $e');
    }
  }
}
