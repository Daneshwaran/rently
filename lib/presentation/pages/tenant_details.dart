import 'package:flutter/material.dart';
import '../../domain/entities/tenant.dart';

class TenantDetails extends StatelessWidget {
  final Tenant tenant;
  const TenantDetails({super.key, required this.tenant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tenant')),
      body: Column(
        children: [
          Text(tenant.name),
          Text(tenant.moveInDate.toIso8601String()),
          Text(tenant.rentAmount.toString()),
          Text(tenant.securityDeposit.toString()),
          Text(tenant.agreementStartDate.toIso8601String()),
          Text(tenant.agreementEndDate.toIso8601String()),
          Text(tenant.isActive.toString()),
          Text(tenant.phoneNumber ?? ''),
          Text(tenant.email ?? ''),
          Text(tenant.createdAt?.toIso8601String() ?? ''),
          Text(tenant.updatedAt?.toIso8601String() ?? ''),
        ],
      ),
    );
  }
}
