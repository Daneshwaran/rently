part of 'tenant_bloc.dart';

abstract class TenantEvent extends Equatable {
  const TenantEvent();

  @override
  List<Object> get props => [];
}

class CreateTenantEvent extends TenantEvent {
  final Tenant tenant;

  const CreateTenantEvent({required this.tenant});

  @override
  List<Object> get props => [tenant];
}

class GetAllTenantsEvent extends TenantEvent {
  const GetAllTenantsEvent();
}

class GetTenantsByHouseIdEvent extends TenantEvent {
  final String houseId;

  const GetTenantsByHouseIdEvent({required this.houseId});

  @override
  List<Object> get props => [houseId];
}

class UpdateTenantEvent extends TenantEvent {
  final Tenant tenant;

  const UpdateTenantEvent({required this.tenant});

  @override
  List<Object> get props => [tenant];
}

class DeleteTenantEvent extends TenantEvent {
  final String id;

  const DeleteTenantEvent({required this.id});

  @override
  List<Object> get props => [id];
}
