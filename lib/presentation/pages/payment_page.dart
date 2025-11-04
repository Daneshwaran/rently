import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/payment.dart';
import '../../application/providers/payment_provider.dart';
import '../../application/providers/rent_calculation_provider.dart';
import '../../application/providers/tenant_provider.dart';
import '../widgets/payment_history_list.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final String houseId;

  const PaymentPage({super.key, required this.houseId});

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  DateTime _paymentDate = DateTime.now();
  String? _tenantId;

  @override
  void initState() {
    super.initState();
    _loadTenant();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _loadTenant() async {
    final tenants = await ref.read(
      tenantsByHouseProvider(widget.houseId).future,
    );
    if (tenants.isNotEmpty) {
      setState(() {
        _tenantId = tenants.first.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final createPaymentState = ref.watch(createPaymentProvider);
    final rentCalculationAsync = ref.watch(
      rentCalculationProvider(widget.houseId),
    );
    final paymentsAsync = ref.watch(paymentsByHouseProvider(widget.houseId));

    final totalAmount = rentCalculationAsync.when(
      data: (rentCalculation) => rentCalculation.totalRent,
      loading: () => 0,
      error: (_, __) => 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Payment'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current Rent Breakdown
            rentCalculationAsync.when(
              data: (rentCalculation) => Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Rent Breakdown',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _buildRentItem(
                        context,
                        'Monthly Rent',
                        rentCalculation.monthlyRent,
                        Colors.blue,
                      ),
                      _buildRentItem(
                        context,
                        'Rent Arrears',
                        rentCalculation.rentArrears,
                        Colors.orange,
                      ),
                      _buildRentItem(
                        context,
                        'Electricity Bill',
                        rentCalculation.electricityBill,
                        Colors.yellow[700]!,
                      ),
                      _buildRentItem(
                        context,
                        'Water Bill',
                        rentCalculation.waterBill,
                        Colors.cyan,
                      ),
                      const Divider(),
                      _buildRentItem(
                        context,
                        'Total Due',
                        rentCalculation.totalRent,
                        Theme.of(context).colorScheme.primary,
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
              ),
              loading: () => const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
              error: (error, stackTrace) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Error loading rent calculation: $error'),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Payment Form
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Record Payment',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'Payment Amount',
                          hintText: 'Enter amount paid',
                          prefixIcon: Icon(Icons.currency_rupee),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter payment amount';
                          }
                          final amount = double.tryParse(value);
                          if (amount == null || amount <= 0) {
                            return 'Please enter a valid amount';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _paymentDate,
                            firstDate: DateTime.now().subtract(
                              const Duration(days: 30),
                            ),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() {
                              _paymentDate = date;
                            });
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Payment Date',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          child: Text(
                            '${_paymentDate.day}/${_paymentDate.month}/${_paymentDate.year}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed:
                            createPaymentState.isLoading || _tenantId == null
                            ? null
                            : _recordPayment,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: createPaymentState.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Record Payment'),
                      ),
                      if (_tenantId == null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'No tenant assigned to this house',
                            style: TextStyle(color: Colors.orange[700]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (createPaymentState.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            'Error: ${createPaymentState.error}',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Payment History
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment History',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    paymentsAsync.when(
                      data: (payments) =>
                          PaymentHistoryList(payments: payments),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) =>
                          Text('Error loading payments: $error'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRentItem(
    BuildContext context,
    String label,
    double amount,
    Color color, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isTotal ? Icons.calculate : Icons.circle,
            color: color,
            size: isTotal ? 20 : 16,
          ),
          const SizedBox(width: 8),
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
            '₹${amount.toStringAsFixed(0)}',
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

  void _recordPayment() {
    final rentCalculationAsync = ref.watch(
      rentCalculationProvider(widget.houseId),
    );
    final totalAmount = rentCalculationAsync.when(
      data: (rentCalculation) => rentCalculation.totalRent,
      loading: () => 0,
      error: (_, __) => 0,
    );
    if (_formKey.currentState!.validate() && _tenantId != null) {
      final payment = Payment(
        id: const Uuid().v4(),
        tenantId: _tenantId!,
        houseId: widget.houseId,
        paidAmount: double.parse(_amountController.text),
        totalAmount: totalAmount as double,
        remainingAmount: totalAmount - double.parse(_amountController.text),
        paymentDate: _paymentDate,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      ref.read(createPaymentProvider.notifier).createPayment(payment).then((_) {
        if (mounted) {
          ref.invalidate(paymentsByHouseProvider(widget.houseId));
          ref.invalidate(rentCalculationProvider(widget.houseId));
          _amountController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment recorded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      });
    }
  }
}
