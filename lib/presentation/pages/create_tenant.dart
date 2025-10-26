import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/bloc/tenant_bloc.dart';
import '../../infrastructure/repositories/tenant_repository_impl.dart';
import '../../domain/entities/tenant.dart';

class CreateTenantPage extends StatefulWidget {
  final String houseId;
  const CreateTenantPage({super.key, required this.houseId});

  @override
  State<CreateTenantPage> createState() => _CreateTenantPageState();
}

class _CreateTenantPageState extends State<CreateTenantPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _uuid = const Uuid();

  DateTime? _moveInDate;
  DateTime? _agreementStartDate;
  DateTime? _agreementEndDate;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TenantBloc(tenantRepository: TenantRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(title: Text('Create Tenant')),
        body: BlocListener<TenantBloc, TenantState>(
          listener: (context, state) {
            if (state is TenantCreated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tenant created successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is TenantError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Phone'),
                    ),

                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _agreementStartDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (picked != null) {
                          setState(() {
                            _agreementStartDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 12),
                            Text(
                              _agreementStartDate == null
                                  ? 'Select Agreement Start Date'
                                  : 'Agreement Start Date: ${_agreementStartDate!.day}/${_agreementStartDate!.month}/${_agreementStartDate!.year}',
                              style: TextStyle(
                                color: _agreementStartDate == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _agreementEndDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (picked != null) {
                          setState(() {
                            _agreementEndDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 12),
                            Text(
                              _agreementEndDate == null
                                  ? 'Select Agreement End Date'
                                  : 'Agreement End Date: ${_agreementEndDate!.day}/${_agreementEndDate!.month}/${_agreementEndDate!.year}',
                              style: TextStyle(
                                color: _agreementEndDate == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _moveInDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (picked != null) {
                          setState(() {
                            _moveInDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 12),
                            Text(
                              _moveInDate == null
                                  ? 'Select Move In Date'
                                  : 'Move In Date: ${_moveInDate!.day}/${_moveInDate!.month}/${_moveInDate!.year}',
                              style: TextStyle(
                                color: _moveInDate == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    BlocBuilder<TenantBloc, TenantState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state is TenantLoading
                              ? () {}
                              : () {
                                  if (_formKey.currentState!.validate() &&
                                      _agreementStartDate != null &&
                                      _agreementEndDate != null &&
                                      _moveInDate != null) {
                                    final tenant = Tenant(
                                      id: _uuid.v4(),
                                      houseId: widget.houseId,
                                      name: _nameController.text,
                                      agreementStartDate: _agreementStartDate!,
                                      agreementEndDate: _agreementEndDate!,
                                      moveInDate: _moveInDate!,
                                      phoneNumber: _phoneController.text,
                                      email: _emailController.text,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                    );

                                    context.read<TenantBloc>().add(
                                      CreateTenantEvent(tenant: tenant),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: state is TenantLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Create Tenant',
                                  style: TextStyle(fontSize: 16),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
