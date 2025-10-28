import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/tenant.dart';
import 'tenant_repository_provider.dart';

final tenantListProvider = FutureProvider<List<Tenant>>((ref) async {
  final repository = ref.read(tenantRepositoryProvider);
  return await repository.getAllTenants();
});

final tenantProvider = FutureProvider.family<Tenant?, String>((
  ref,
  tenantId,
) async {
  final repository = ref.read(tenantRepositoryProvider);
  return await repository.getTenantById(tenantId);
});

final tenantsByHouseProvider = FutureProvider.family<List<Tenant>, String>((
  ref,
  houseId,
) async {
  final repository = ref.read(tenantRepositoryProvider);
  return await repository.getTenantsByHouseId(houseId);
});

final createTenantProvider =
    StateNotifierProvider<CreateTenantNotifier, AsyncValue<void>>((ref) {
      return CreateTenantNotifier(ref.read(tenantRepositoryProvider));
    });

class CreateTenantNotifier extends StateNotifier<AsyncValue<void>> {
  final tenantRepository;

  CreateTenantNotifier(this.tenantRepository)
    : super(const AsyncValue.data(null));

  Future<void> createTenant(Tenant tenant) async {
    state = const AsyncValue.loading();
    try {
      // Check if tenant already exists for this house
      final existingTenants = await tenantRepository.getTenantsByHouseId(
        tenant.houseId,
      );

      // Archive existing tenant if any
      for (final existingTenant in existingTenants) {
        if (existingTenant.id != null) {
          // Update existing tenant to mark as inactive or add end date
          final updatedTenant = existingTenant.copyWith(
            agreementEndDate: DateTime.now(),
          );
          await tenantRepository.updateTenant(updatedTenant);
        }
      }

      await tenantRepository.createTenant(tenant);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final updateTenantProvider =
    StateNotifierProvider<UpdateTenantNotifier, AsyncValue<void>>((ref) {
      return UpdateTenantNotifier(ref.read(tenantRepositoryProvider));
    });

class UpdateTenantNotifier extends StateNotifier<AsyncValue<void>> {
  final tenantRepository;

  UpdateTenantNotifier(this.tenantRepository)
    : super(const AsyncValue.data(null));

  Future<void> updateTenant(Tenant tenant) async {
    state = const AsyncValue.loading();
    try {
      await tenantRepository.updateTenant(tenant);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final deleteTenantProvider =
    StateNotifierProvider<DeleteTenantNotifier, AsyncValue<void>>((ref) {
      return DeleteTenantNotifier(ref.read(tenantRepositoryProvider));
    });

class DeleteTenantNotifier extends StateNotifier<AsyncValue<void>> {
  final tenantRepository;

  DeleteTenantNotifier(this.tenantRepository)
    : super(const AsyncValue.data(null));

  Future<void> deleteTenant(String tenantId) async {
    state = const AsyncValue.loading();
    try {
      await tenantRepository.deleteTenant(tenantId);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
