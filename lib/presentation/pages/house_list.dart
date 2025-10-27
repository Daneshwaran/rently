import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/house.dart';
import '../../application/bloc/house_bloc.dart';
import '../../application/bloc/tenant_bloc.dart';
import '../../infrastructure/repositories/tenant_repository_impl.dart';
import 'tenant_rent_page.dart';

class HouseListWidget extends StatefulWidget {
  const HouseListWidget({super.key});

  @override
  State<HouseListWidget> createState() => _HouseListWidgetState();
}

class _HouseListWidgetState extends State<HouseListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseBloc, HouseState>(
      builder: (context, state) {
        if (state is HouseLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HousesLoaded) {
          if (state.houses.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No houses found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the + button to add your first house',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HouseBloc>().add(const GetAllHousesEvent());
            },
            child: ListView.builder(
              itemCount: state.houses.length,
              itemBuilder: (context, index) {
                final house = state.houses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: ListTile(
                    onTap: () {
                      // Capture the bloc before navigation
                      final houseBloc = context.read<HouseBloc>();

                      final tenantBloc = TenantBloc(
                        tenantRepository: TenantRepositoryImpl(),
                      );
                      tenantBloc.add(
                        GetTenantsByHouseIdEvent(houseId: house.id),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(value: houseBloc),
                              BlocProvider.value(value: tenantBloc),
                            ],
                            child: TenantRentPage(house: house),
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: house.isAvailable
                          ? Colors.green
                          : Colors.red,
                      child: Icon(
                        house.isAvailable ? Icons.home : Icons.home_outlined,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      house.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rent: \$${house.monthlyRent.toStringAsFixed(2)}/month',
                        ),
                        Text('Due: ${_formatDate(house.rentDueDate)}'),
                        Text(
                          house.isAvailable ? 'Occupied' : 'Vacant',
                          style: TextStyle(
                            color: house.isAvailable
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    isThreeLine: true,
                  ),
                );
              },
            ),
          );
        } else if (state is HouseError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error loading houses',
                  style: TextStyle(fontSize: 18, color: Colors.red[700]),
                ),
                const SizedBox(height: 8),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<HouseBloc>().add(const GetAllHousesEvent());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return const Center(child: Text('No data available'));
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showDeleteDialog(BuildContext context, House house) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete House'),
          content: Text('Are you sure you want to delete "${house.name}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<HouseBloc>().add(
                  DeleteHouseEvent(houseId: house.id),
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${house.name} deleted successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
