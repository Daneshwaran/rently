import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/tenant.dart';
import '../../application/providers/tenant_provider.dart';

class TenantFormPage extends ConsumerStatefulWidget {
  final String houseId;

  const TenantFormPage({super.key, required this.houseId});

  @override
  ConsumerState<TenantFormPage> createState() => _TenantFormPageState();
}

class _TenantFormPageState extends ConsumerState<TenantFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  DateTime _moveInDate = DateTime.now();
  DateTime _agreementStartDate = DateTime.now();
  DateTime _agreementEndDate = DateTime.now().add(const Duration(days: 365));
  bool _hasExistingTenant = false;

  @override
  void initState() {
    super.initState();
    _checkExistingTenant();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _checkExistingTenant() async {
    final tenants = await ref.read(
      tenantsByHouseProvider(widget.houseId).future,
    );
    setState(() {
      _hasExistingTenant = tenants.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final createTenantState = ref.watch(createTenantProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_hasExistingTenant ? 'Replace Tenant' : 'Add Tenant'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_hasExistingTenant)
                Card(
                  color: Colors.orange.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.warning, color: Colors.orange),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'A tenant already exists for this house. Adding a new tenant will replace the existing one.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.orange[800]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (_hasExistingTenant) const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tenant Name',
                  hintText: 'e.g., John Doe',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter tenant name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'e.g., +91 9876543210',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    if (value.trim().length < 10) {
                      return 'Please enter a valid phone number';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email (Optional)',
                  hintText: 'e.g., john@example.com',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _moveInDate,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 365),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _moveInDate = date;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Move-in Date',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    '${_moveInDate.day}/${_moveInDate.month}/${_moveInDate.year}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _agreementStartDate,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 365),
                    ),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _agreementStartDate = date;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Agreement Start Date',
                    prefixIcon: Icon(Icons.event),
                  ),
                  child: Text(
                    '${_agreementStartDate.day}/${_agreementStartDate.month}/${_agreementStartDate.year}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _agreementEndDate,
                    firstDate: _agreementStartDate,
                    lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
                  );
                  if (date != null) {
                    setState(() {
                      _agreementEndDate = date;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Agreement End Date',
                    prefixIcon: Icon(Icons.event_available),
                  ),
                  child: Text(
                    '${_agreementEndDate.day}/${_agreementEndDate.month}/${_agreementEndDate.year}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: createTenantState.isLoading ? null : _createTenant,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: createTenantState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        _hasExistingTenant ? 'Replace Tenant' : 'Add Tenant',
                      ),
              ),
              if (createTenantState.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Error: ${createTenantState.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _createTenant() {
    if (_formKey.currentState!.validate()) {
      final tenant = Tenant(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        houseId: widget.houseId,
        moveInDate: _moveInDate,
        agreementStartDate: _agreementStartDate,
        agreementEndDate: _agreementEndDate,
        phoneNumber: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        email: _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      ref.read(createTenantProvider.notifier).createTenant(tenant).then((_) {
        if (mounted) {
          ref.invalidate(tenantsByHouseProvider(widget.houseId));
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _hasExistingTenant
                    ? 'Tenant replaced successfully!'
                    : 'Tenant added successfully!',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      });
    }
  }
}
