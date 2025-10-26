import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/tenant.dart';
import '../../domain/repositories/tenant_repository.dart';

part 'tenant_event.dart';
part 'tenant_state.dart';

class TenantBloc extends Bloc<TenantEvent, TenantState> {
  final TenantRepository _tenantRepository;

  TenantBloc({required TenantRepository tenantRepository})
    : _tenantRepository = tenantRepository,
      super(TenantInitial()) {
    on<CreateTenantEvent>(_onCreateTenant);
    on<GetAllTenantsEvent>(_onGetAllTenants);
    on<GetTenantsByHouseIdEvent>(_onGetTenantsByHouseId);
    on<UpdateTenantEvent>(_onUpdateTenant);
    on<DeleteTenantEvent>(_onDeleteTenant);
  }

  Future<void> _onCreateTenant(
    CreateTenantEvent event,
    Emitter<TenantState> emit,
  ) async {
    emit(TenantLoading());
    try {
      print('Creating tenant: ${event.tenant.toJson()}');
      final tenant = await _tenantRepository.createTenant(event.tenant);
      emit(TenantCreated(tenant));
    } catch (e) {
      emit(TenantError(e.toString()));
    }
  }

  Future<void> _onGetAllTenants(
    GetAllTenantsEvent event,
    Emitter<TenantState> emit,
  ) async {
    emit(TenantLoading());
    try {
      final tenants = await _tenantRepository.getAllTenants();
      emit(TenantsLoaded(tenants));
    } catch (e) {
      emit(TenantError(e.toString()));
    }
  }

  Future<void> _onGetTenantsByHouseId(
    GetTenantsByHouseIdEvent event,
    Emitter<TenantState> emit,
  ) async {
    emit(TenantLoading());
    try {
      final tenants = await _tenantRepository.getTenantsByHouseId(
        event.houseId,
      );
      emit(TenantsLoaded(tenants));
    } catch (e) {
      emit(TenantError(e.toString()));
    }
  }

  Future<void> _onUpdateTenant(
    UpdateTenantEvent event,
    Emitter<TenantState> emit,
  ) async {
    emit(TenantLoading());
    try {
      final tenant = await _tenantRepository.updateTenant(event.tenant);
      emit(TenantUpdated(tenant));
    } catch (e) {
      emit(TenantError(e.toString()));
    }
  }

  Future<void> _onDeleteTenant(
    DeleteTenantEvent event,
    Emitter<TenantState> emit,
  ) async {
    emit(TenantLoading());
    try {
      await _tenantRepository.deleteTenant(event.id);
      emit(TenantDeleted(event.id));
    } catch (e) {
      emit(TenantError(e.toString()));
    }
  }
}
