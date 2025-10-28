import 'package:flutter/material.dart';
import '../../domain/entities/payment.dart';

class PaymentHistoryList extends StatelessWidget {
  final List<Payment> payments;

  const PaymentHistoryList({super.key, required this.payments});

  @override
  Widget build(BuildContext context) {
    if (payments.isEmpty) {
      return const Center(
        child: Column(
          children: [
            Icon(Icons.payment_outlined, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              'No payments recorded yet',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: payments.length,
      itemBuilder: (context, index) {
        final payment = payments[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getPaymentTypeColor(
                payment.paymentType,
              ).withOpacity(0.1),
              child: Icon(
                _getPaymentTypeIcon(payment.paymentType),
                color: _getPaymentTypeColor(payment.paymentType),
              ),
            ),
            title: Text(
              _getPaymentTypeLabel(payment.paymentType),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              '${payment.paymentDate.day}/${payment.paymentDate.month}/${payment.paymentDate.year}',
            ),
            trailing: Text(
              '₹${payment.amount.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getPaymentTypeColor(PaymentType type) {
    switch (type) {
      case PaymentType.rent:
        return Colors.blue;
      case PaymentType.electricity:
        return Colors.yellow[700]!;
      case PaymentType.water:
        return Colors.cyan;
      case PaymentType.partial:
        return Colors.orange;
    }
  }

  IconData _getPaymentTypeIcon(PaymentType type) {
    switch (type) {
      case PaymentType.rent:
        return Icons.home;
      case PaymentType.electricity:
        return Icons.electrical_services;
      case PaymentType.water:
        return Icons.water_drop;
      case PaymentType.partial:
        return Icons.payment;
    }
  }

  String _getPaymentTypeLabel(PaymentType type) {
    switch (type) {
      case PaymentType.rent:
        return 'Rent Payment';
      case PaymentType.electricity:
        return 'Electricity Bill';
      case PaymentType.water:
        return 'Water Bill';
      case PaymentType.partial:
        return 'Partial Payment';
    }
  }
}
