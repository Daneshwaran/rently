import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/repositories/tenant_repository_impl.dart';
import '../../domain/repositories/tenant_repository.dart';

final tenantRepositoryProvider = Provider<TenantRepository>((ref) {
  return TenantRepositoryImpl();
});
