import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/house.dart';
import '../../application/providers/house_provider.dart';

class CreateHousePage extends ConsumerStatefulWidget {
  const CreateHousePage({super.key});

  @override
  ConsumerState<CreateHousePage> createState() => _CreateHousePageState();
}

class _CreateHousePageState extends ConsumerState<CreateHousePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _monthlyRentController = TextEditingController();
  final _securityDepositController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Hard code rent due date to the 10th of next month (current year)
  DateTime get _rentDueDate {
    final now = DateTime.now();
    // Always use the 10th of next month
    if (now.month == 12) {
      // If December, roll over to January of next year
      return DateTime(now.year + 1, 1, 10);
    } else {
      return DateTime(now.year, now.month + 1, 10);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _monthlyRentController.dispose();
    _securityDepositController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createHouseState = ref.watch(createHouseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New House'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'House Name',
                  hintText: 'e.g., Apartment 101, Villa Green',
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter house name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: createHouseState.isLoading ? null : _createHouse,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: createHouseState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create House'),
              ),
              if (createHouseState.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Error: ${createHouseState.error}',
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

  void _createHouse() {
    if (_formKey.currentState!.validate()) {
      final house = House(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      ref.read(createHouseProvider.notifier).createHouse(house).then((_) {
        if (mounted) {
          ref.invalidate(houseListProvider);
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('House created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      });
    }
  }
}
