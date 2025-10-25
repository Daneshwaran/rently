import 'dart:developer';
import '../../domain/entities/house.dart';
import '../../domain/repositories/house_repository.dart';

class HouseRepositoryImpl implements HouseRepository {
  final List<House> _houses = [];

  @override
  Future<House> createHouse(House house) async {
    print('Creating house: ${house.name}');
    print('House details: ${house.toJson()}');

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _houses.add(house);
    print('House created successfully with ID: ${house.id}');
    print('Total houses in repository: ${_houses.length}');

    return house;
  }

  @override
  Future<List<House>> getAllHouses() async {
    log('Getting all houses');
    log('Total houses: ${_houses.length}');

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return List.from(_houses);
  }

  @override
  Future<House?> getHouseById(String id) async {
    log('Getting house by ID: $id');

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      final house = _houses.firstWhere((house) => house.id == id);
      log('House found: ${house.name}');
      return house;
    } catch (e) {
      log('House not found with ID: $id');
      return null;
    }
  }

  @override
  Future<House> updateHouse(House house) async {
    log('Updating house: ${house.name}');
    log('Updated house details: ${house.toJson()}');

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    final index = _houses.indexWhere((h) => h.id == house.id);
    if (index != -1) {
      _houses[index] = house;
      log('House updated successfully');
    } else {
      log('House not found for update');
      throw Exception('House not found');
    }

    return house;
  }

  @override
  Future<void> deleteHouse(String id) async {
    log('Deleting house with ID: $id');

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _houses.indexWhere((house) => house.id == id);
    if (index != -1) {
      final house = _houses.removeAt(index);
      log('House deleted: ${house.name}');
      log('Remaining houses: ${_houses.length}');
    } else {
      log('House not found for deletion');
      throw Exception('House not found');
    }
  }
}
