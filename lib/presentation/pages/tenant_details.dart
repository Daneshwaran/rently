import 'package:flutter/material.dart';
import '../../domain/entities/tenant.dart';

class TenantDetails extends StatelessWidget {
  final Tenant tenant;
  const TenantDetails({super.key, required this.tenant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tenant')),
      body: Column(children: [Text(tenant.name)]),
    );
  }
}
