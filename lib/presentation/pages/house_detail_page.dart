import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/house_provider.dart';
import '../../application/providers/tenant_provider.dart';
import '../../application/providers/rent_calculation_provider.dart';
import '../widgets/rent_breakdown_card.dart';
import '../widgets/tenant_info_card.dart';

class HouseDetailPage extends ConsumerWidget {
  final String houseId;

  const HouseDetailPage({super.key, required this.houseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final houseAsync = ref.watch(houseProvider(houseId));
    final tenantsAsync = ref.watch(tenantsByHouseProvider(houseId));
    final rentCalculationAsync = ref.watch(rentCalculationProvider(houseId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('House Details'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit house page
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteDialog(context, ref),
          ),
        ],
      ),
      body: houseAsync.when(
        data: (house) {
          if (house == null) {
            return const Center(child: Text('House not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tenant Information
                tenantsAsync.when(
                  data: (tenants) {
                    if (tenants.isEmpty) {
                      return Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 48,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'No tenant assigned',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () =>
                                    context.go('/house/$houseId/tenant/create'),
                                icon: const Icon(Icons.person_add),
                                label: const Text('Add Tenant'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final currentTenant = tenants.first;
                    return TenantInfoCard(
                      tenant: currentTenant,
                      onEdit: () => context.go(
                        '/house/$houseId/tenant/edit/${currentTenant.id}',
                      ),
                      onDelete: () => _showDeleteTenantDialog(
                        context,
                        ref,
                        currentTenant.id!,
                      ),
                      onReplace: () =>
                          context.go('/house/$houseId/tenant/create'),
                    );
                  },
                  loading: () => const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  error: (error, stackTrace) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Error loading tenant: $error',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => context.go('/house/$houseId/meter-reading'),
                  icon: const Icon(Icons.speed),
                  label: const Text('Meter Reading'),
                ),
                // Rent Breakdown Card
                rentCalculationAsync.when(
                  data: (rentCalculation) =>
                      RentBreakdownCard(rentCalculation: rentCalculation),
                  loading: () => const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  error: (error, stackTrace) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Error loading rent calculation: $error',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => context.go('/house/$houseId/payment'),
                  icon: const Icon(Icons.payment),
                  label: const Text('Record Payment'),
                ),

                const SizedBox(height: 16),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error loading house',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(houseProvider(houseId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteTenantDialog(
    BuildContext context,
    WidgetRef ref,
    String tenantId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Tenant'),
        content: const Text(
          'Are you sure you want to delete this tenant? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref
                  .read(deleteTenantProvider.notifier)
                  .deleteTenant(tenantId)
                  .then((_) {
                    if (context.mounted) {
                      context.go('/house/$houseId');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tenant deleted successfully!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  });
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete House'),
        content: const Text(
          'Are you sure you want to delete this house? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(deleteHouseProvider.notifier).deleteHouse(houseId).then((
                _,
              ) {
                if (context.mounted) {
                  context.go('/');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('House deleted successfully!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              });
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
