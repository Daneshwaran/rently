import 'package:flutter/material.dart';
import '../../domain/entities/tenant.dart';
import '../../application/bloc/tenant_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TenantDetails extends StatelessWidget {
  final Tenant tenant;
  final String houseId;
  const TenantDetails({super.key, required this.tenant, required this.houseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tenant')),
      body: Column(
        children: [
          Text(tenant.name),
          Text(tenant.moveInDate.toIso8601String()),
          Text(tenant.agreementStartDate.toIso8601String()),
          Text(tenant.agreementEndDate.toIso8601String()),
          Text(tenant.phoneNumber ?? ''),
          Text(tenant.email ?? ''),
          Text(tenant.createdAt?.toIso8601String() ?? ''),
          Text(tenant.updatedAt?.toIso8601String() ?? ''),
          deleteTenantButton(context),
          BlocListener<TenantBloc, TenantState>(
            listener: (context, state) {
              if (state is TenantDeleted) {
                // Refresh the tenant list in the parent widget
                context.read<TenantBloc>().add(
                  GetTenantsByHouseIdEvent(houseId: houseId),
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tenant deleted successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is TenantError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Container(),
          ),
          BlocBuilder<TenantBloc, TenantState>(
            builder: (context, state) {
              return state is TenantDeleting
                  ? const CircularProgressIndicator()
                  : Container();
            },
          ),
        ],
      ),
    );
  }

  Widget deleteTenantButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          context.read<TenantBloc>().add(
            DeleteTenantEvent(id: tenant.id ?? ''),
          );
        },
        child: const Text('Delete Tenant'),
      ),
    );
  }
}
