import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/meter_reading.dart';
import '../../application/providers/meter_reading_provider.dart';

class MeterReadingPage extends ConsumerStatefulWidget {
  final String houseId;

  const MeterReadingPage({super.key, required this.houseId});

  @override
  ConsumerState<MeterReadingPage> createState() => _MeterReadingPageState();
}

class _MeterReadingPageState extends ConsumerState<MeterReadingPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentReadingController = TextEditingController();
  final _rateController = TextEditingController();
  ReadingType _selectedType = ReadingType.electricity;
  DateTime _readingDate = DateTime.now();
  double _previousReading = 0.0;
  double _calculatedAmount = 0.0;
  bool _hasLoadedInitialReading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoadedInitialReading) {
      _loadInitialReading();
    }
  }

  Future<void> _loadInitialReading() async {
    final latestReadingAsync = ref.read(
      latestMeterReadingProvider((
        houseId: widget.houseId,
        readingType: _selectedType,
      )).future,
    );

    try {
      final reading = await latestReadingAsync;
      if (mounted) {
        setState(() {
          _previousReading = reading?.currentReading ?? 0.0;
          _hasLoadedInitialReading = true;
        });
      }
    } catch (e) {
      // Handle error silently, will default to 0.0
      if (mounted) {
        setState(() {
          _hasLoadedInitialReading = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _currentReadingController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  void _calculateAmount() {
    final currentReading =
        double.tryParse(_currentReadingController.text) ?? 0.0;
    final rate = double.tryParse(_rateController.text) ?? 0.0;
    final usage = currentReading - _previousReading;
    final amount = usage * rate;

    setState(() {
      _calculatedAmount = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final createMeterReadingState = ref.watch(createMeterReadingProvider);

    // Watch the provider to ensure it's active and triggers on readingType changes
    ref.watch(
      latestMeterReadingProvider((
        houseId: widget.houseId,
        readingType: _selectedType,
      )),
    );

    // Update _previousReading when the provider value changes (e.g., when reading type changes)
    ref.listen(
      latestMeterReadingProvider((
        houseId: widget.houseId,
        readingType: _selectedType,
      )),
      (previous, next) {
        next.whenData((reading) {
          final newPreviousReading = reading?.currentReading ?? 0.0;
          if (mounted && _previousReading != newPreviousReading) {
            setState(() {
              _previousReading = newPreviousReading;
            });
          }
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Meter Reading'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Reading Type Selection
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reading Type',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: [
                          RadioListTile<ReadingType>(
                            title: const Text('Electricity'),
                            subtitle: const Text('Power consumption'),
                            value: ReadingType.electricity,
                            groupValue: _selectedType,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedType = value;
                                  _currentReadingController.clear();
                                  _rateController.clear();
                                  _calculatedAmount = 0.0;
                                });
                                _loadInitialReading();
                              }
                            },
                          ),
                          RadioListTile<ReadingType>(
                            title: const Text('Water'),
                            subtitle: const Text('Water consumption'),
                            value: ReadingType.water,
                            groupValue: _selectedType,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedType = value;
                                  _currentReadingController.clear();
                                  _rateController.clear();
                                  _calculatedAmount = 0.0;
                                });
                                _loadInitialReading();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Previous Reading Display
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        _selectedType == ReadingType.electricity
                            ? Icons.electrical_services
                            : Icons.water_drop,
                        color: _selectedType == ReadingType.electricity
                            ? Colors.yellow[700]
                            : Colors.cyan,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Previous Reading',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                            Text(
                              _previousReading.toStringAsFixed(2),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Current Reading Input
              TextFormField(
                controller: _currentReadingController,
                decoration: InputDecoration(
                  labelText: 'Current Reading',
                  hintText: 'Enter current meter reading',
                  prefixIcon: Icon(
                    _selectedType == ReadingType.electricity
                        ? Icons.electrical_services
                        : Icons.water_drop,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) => _calculateAmount(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter current reading';
                  }
                  final reading = double.tryParse(value);
                  if (reading == null || reading < 0) {
                    return 'Please enter a valid reading';
                  }
                  if (reading < _previousReading) {
                    return 'Current reading cannot be less than previous reading';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Rate Input
              TextFormField(
                controller: _rateController,
                decoration: const InputDecoration(
                  labelText: 'Rate per Unit',
                  hintText: 'e.g., 5.50',
                  prefixIcon: Icon(Icons.currency_rupee),
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) => _calculateAmount(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter rate per unit';
                  }
                  final rate = double.tryParse(value);
                  if (rate == null || rate <= 0) {
                    return 'Please enter a valid rate';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Reading Date
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _readingDate,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _readingDate = date;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Reading Date',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    '${_readingDate.day}/${_readingDate.month}/${_readingDate.year}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Calculation Display
              if (_calculatedAmount > 0)
                Card(
                  color: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calculate,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Bill Calculation',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildCalculationRow(
                          context,
                          'Usage',
                          '${(double.tryParse(_currentReadingController.text) ?? 0.0) - _previousReading} units',
                        ),
                        _buildCalculationRow(
                          context,
                          'Rate',
                          '₹${_rateController.text} per unit',
                        ),
                        const Divider(),
                        _buildCalculationRow(
                          context,
                          'Total Amount',
                          '₹${_calculatedAmount.toStringAsFixed(2)}',
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: createMeterReadingState.isLoading
                    ? null
                    : _saveMeterReading,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: createMeterReadingState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save Meter Reading'),
              ),
              if (createMeterReadingState.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Error: ${createMeterReadingState.error}',
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

  Widget _buildCalculationRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 16 : 14,
              ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isTotal ? Theme.of(context).colorScheme.primary : null,
              fontSize: isTotal ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }

  void _saveMeterReading() {
    if (_formKey.currentState!.validate()) {
      final currentReading = double.parse(_currentReadingController.text);
      final rate = double.parse(_rateController.text);
      final usage = currentReading - _previousReading;
      final amount = usage * rate;

      final meterReading = MeterReading(
        id: const Uuid().v4(),
        houseId: widget.houseId,
        readingType: _selectedType,
        currentReading: currentReading,
        previousReading: _previousReading,
        readingDate: _readingDate,
        ratePerUnit: rate,
        calculatedAmount: amount,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      ref
          .read(createMeterReadingProvider.notifier)
          .createMeterReading(meterReading)
          .then((_) {
            if (mounted) {
              ref.invalidate(meterReadingsByHouseProvider(widget.houseId));
              ref.invalidate(
                latestMeterReadingProvider((
                  houseId: widget.houseId,
                  readingType: _selectedType,
                )),
              );
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Meter reading saved successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          });
    }
  }
}
