import '../entities/tenant.dart';

abstract class TenantRepository {
  Future<Tenant> createTenant(Tenant tenant);
  Future<List<Tenant>> getAllTenants();
  Future<Tenant?> getTenantById(String id);
  Future<List<Tenant>> getTenantsByHouseId(String houseId);
  Future<Tenant> updateTenant(Tenant tenant);
  Future<void> deleteTenant(String id);
}
