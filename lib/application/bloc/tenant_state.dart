part of 'tenant_bloc.dart';

abstract class TenantState extends Equatable {
  const TenantState();

  @override
  List<Object> get props => [];
}

class TenantInitial extends TenantState {}

class TenantLoading extends TenantState {}

class TenantCreated extends TenantState {
  final Tenant tenant;

  const TenantCreated(this.tenant);

  @override
  List<Object> get props => [tenant];
}

class TenantsLoaded extends TenantState {
  final List<Tenant> tenants;

  const TenantsLoaded(this.tenants);

  @override
  List<Object> get props => [tenants];
}

class TenantUpdated extends TenantState {
  final Tenant tenant;

  const TenantUpdated(this.tenant);

  @override
  List<Object> get props => [tenant];
}

class TenantDeleted extends TenantState {
  final String id;

  const TenantDeleted(this.id);

  @override
  List<Object> get props => [id];
}

class TenantError extends TenantState {
  final String message;

  const TenantError(this.message);

  @override
  List<Object> get props => [message];
}
