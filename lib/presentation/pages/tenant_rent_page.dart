import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/house.dart';
import '../../domain/entities/tenant.dart';
import '../../application/bloc/tenant_bloc.dart';
import '../../infrastructure/repositories/tenant_repository_impl.dart';
import 'create_tenant.dart';
import 'tenant_details.dart';
import '../../application/bloc/house_bloc.dart';
import 'edit_house.dart';

class TenantRentPage extends StatefulWidget {
  final House house;

  const TenantRentPage({super.key, required this.house});

  @override
  State<TenantRentPage> createState() => _TenantRentPageState();
}

class _TenantRentPageState extends State<TenantRentPage> {
  late final TenantBloc _tenantBloc;

  @override
  void initState() {
    super.initState();
    _tenantBloc = TenantBloc(tenantRepository: TenantRepositoryImpl());
    // Load tenants for this house
    _tenantBloc.add(GetTenantsByHouseIdEvent(houseId: widget.house.id ?? ''));
  }

  @override
  void dispose() {
    _tenantBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _tenantBloc,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          title: Text(
            'House #${widget.house.id?.substring(0, 8) ?? 'Unknown'}',
          ),
          backgroundColor: const Color(0xFFA06A4F),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // House Header
              _buildHouseHeader(),
              const SizedBox(height: 20),

              // Tenant Section
              _buildTenantSection(),
              const SizedBox(height: 20),

              // Monthly Billing Section
              _buildMonthlyBillingSection(),

              deleteHouseButton(),
              editHouseButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget editHouseButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: _tenantBloc,
                child: EditHousePage(house: widget.house),
              ),
            ),
          );
        },
        child: const Text('Edit House'),
      ),
    );
  }

  Widget deleteHouseButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          context.read<HouseBloc>().add(
            DeleteHouseEvent(houseId: widget.house.id ?? ''),
          );
        },
        child: const Text('Delete House'),
      ),
    );
  }

  Widget _buildHouseHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFA06A4F),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'House #${widget.house.id?.substring(0, 8) ?? 'Unknown'}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.house.name,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHouseInfo('Rent', '₹${widget.house.monthlyRent.toInt()}'),
              _buildHouseInfo(
                'Deposit',
                '₹${widget.house.securityDeposit.toInt()}',
              ),
              _buildHouseInfo(
                'Status',
                widget.house.isAvailable ? 'Available' : 'Occupied',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHouseInfo(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildTenantSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tenant',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<TenantBloc, TenantState>(
            builder: (context, state) {
              if (state is TenantLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TenantsLoaded) {
                if (state.tenants.isEmpty) {
                  return _buildNoTenantCard();
                }
                return _buildTenantCard(state.tenants.first);
              } else if (state is TenantError) {
                return _buildErrorCard(state.message);
              }
              return _buildNoTenantCard();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoTenantCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.person_outline, color: Colors.grey, size: 24),
          SizedBox(width: 12),
          Text(
            'No tenant linked       ',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: _tenantBloc,
                    child: CreateTenantPage(houseId: widget.house.id ?? ''),
                  ),
                ),
              );
            },
            icon: Icon(Icons.link),
          ),
        ],
      ),
    );
  }

  Widget _buildTenantCard(Tenant tenant) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _tenantBloc,
              child: TenantDetails(
                tenant: tenant,
                houseId: widget.house.id ?? '',
              ),
            ),
          ),
        );
      },

      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8F2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(Icons.person, color: Color(0xFF8B4513), size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tenant.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Since ${_formatDate(tenant.moveInDate)}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF8B4513),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.error, color: Colors.red, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Error: $message',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyBillingSection() {
    final electricityUsage = 200;
    final waterUsage = 100;
    final rent = widget.house.monthlyRent;
    final rentDueDate = widget.house.rentDueDate;
    final rentArrears = 100;
    final electricityBill = 200;
    final waterBill = 100;
    final totalAmount = rent + rentArrears + electricityBill + waterBill;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildBillingItem(
                      'Rent arrears',
                      '$rentArrears INR',
                      Colors.green,
                    ),
                    const SizedBox(height: 12),
                    _buildBillingItem(
                      'Electricity usage',
                      '$electricityUsage watts',
                      Colors.black,
                    ),
                    const SizedBox(height: 12),
                    _buildBillingItem(
                      'Water usage',
                      '$waterUsage liters',
                      Colors.black,
                    ),
                    const SizedBox(height: 12),
                    _buildBillingItem(
                      'Due date',
                      _formatDate(rentDueDate),
                      Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBillingItem('Rent', '$rent INR', Colors.black),
                    const SizedBox(height: 12),
                    _buildBillingItem(
                      'Electricity bill',
                      '$electricityBill INR',
                      Colors.black,
                    ),
                    const SizedBox(height: 12),
                    _buildBillingItem(
                      'Water bill',
                      '$waterBill INR',
                      Colors.black,
                    ),
                    const SizedBox(height: 12),
                    _buildBillingItem(
                      'Total amount',
                      '$totalAmount INR',
                      const Color(0xFFA06A4F),
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillingItem(
    String label,
    String value,
    Color valueColor, {
    bool isTotal = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
