import 'package:flutter/material.dart';
import '../../domain/entities/tenant.dart';

class TenantInfoCard extends StatelessWidget {
  final Tenant tenant;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onReplace;
  const TenantInfoCard({
    super.key,
    required this.tenant,
    required this.onEdit,
    required this.onDelete,
    required this.onReplace,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blue, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Current Tenant',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
                IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
                IconButton(
                  icon: const Icon(Icons.find_replace),
                  onPressed: onReplace,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(context, 'Name', tenant.name),
            if (tenant.phoneNumber != null && tenant.phoneNumber!.isNotEmpty)
              _buildInfoRow(context, 'Phone', tenant.phoneNumber!),
            if (tenant.email != null && tenant.email!.isNotEmpty)
              _buildInfoRow(context, 'Email', tenant.email!),
            _buildInfoRow(
              context,
              'Move-in Date',
              '${tenant.moveInDate.day}/${tenant.moveInDate.month}/${tenant.moveInDate.year}',
            ),
            _buildInfoRow(
              context,
              'Agreement Start',
              '${tenant.agreementStartDate.day}/${tenant.agreementStartDate.month}/${tenant.agreementStartDate.year}',
            ),
            _buildInfoRow(
              context,
              'Agreement End',
              '${tenant.agreementEndDate.day}/${tenant.agreementEndDate.month}/${tenant.agreementEndDate.year}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
