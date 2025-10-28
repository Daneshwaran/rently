import 'package:flutter/material.dart';
import '../../domain/entities/rent_calculation.dart';

class RentBreakdownCard extends StatelessWidget {
  final RentCalculation rentCalculation;

  const RentBreakdownCard({super.key, required this.rentCalculation});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rent Breakdown',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildRentItem(
              context,
              'Monthly Rent',
              rentCalculation.monthlyRent,
              Icons.home,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildRentItem(
              context,
              'Rent Arrears',
              rentCalculation.rentArrears,
              Icons.schedule,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildRentItem(
              context,
              'Electricity Bill',
              rentCalculation.electricityBill,
              Icons.electrical_services,
              Colors.yellow[700]!,
            ),
            const SizedBox(height: 12),
            _buildRentItem(
              context,
              'Water Bill',
              rentCalculation.waterBill,
              Icons.water_drop,
              Colors.cyan,
            ),
            const Divider(height: 24),
            _buildRentItem(
              context,
              'Total Rent',
              rentCalculation.totalRent,
              Icons.calculate,
              Theme.of(context).colorScheme.primary,
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRentItem(
    BuildContext context,
    String label,
    double amount,
    IconData icon,
    Color color, {
    bool isTotal = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: isTotal ? 24 : 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ),
        Text(
          '₹${amount.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isTotal ? Theme.of(context).colorScheme.primary : null,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
      ],
    );
  }
}
