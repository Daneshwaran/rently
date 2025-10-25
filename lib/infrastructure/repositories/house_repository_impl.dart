import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/house.dart';
import '../../domain/repositories/house_repository.dart';

class HouseRepositoryImpl implements HouseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'houses';
  final String _userId = "q7KfG9dLw3S2";

  @override
  Future<House> createHouse(House house) async {
    try {
      // Save to Firebase Firestore collection "houses"
      final houseDocument = house.toJson()..['userId'] = _userId;
      await _firestore
          .collection(_collectionName)
          .doc(house.id)
          .set(houseDocument);

      print('House saved to Firestore successfully with ID: ${house.id}');
      return house;
    } catch (e) {
      print('Error saving house to Firestore: $e');
      throw Exception('Failed to save house: $e');
    }
  }

  @override
  Future<List<House>> getAllHouses() async {
    print('Getting all houses from Firestore');

    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: _userId)
          .get();
      print(snapshot.docs[0].data());

      final List<dynamic> houses = snapshot.docs
          .map((doc) => doc.data())
          .toList();

      print('Retrieved ${houses.length} houses from Firestore');
      return houses
          .map((house) => House.fromJson(house as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting houses from Firestore: $e');
      throw Exception('Failed to get houses: $e');
    }
  }

  @override
  Future<House?> getHouseById(String id) async {
    print('Getting house by ID: $id');

    try {
      final DocumentSnapshot doc = await _firestore
          .collection(_collectionName)
          .doc(id)
          .get();

      if (doc.exists) {
        final house = House.fromJson(doc.data() as Map<String, dynamic>);
        print('House found: ${house.name}');
        return house;
      } else {
        print('House not found with ID: $id');
        return null;
      }
    } catch (e) {
      print('Error getting house from Firestore: $e');
      throw Exception('Failed to get house: $e');
    }
  }

  @override
  Future<House> updateHouse(House house) async {
    print('Updating house: ${house.name}');
    print('Updated house details: ${house.toJson()}');

    try {
      // Update the house in Firestore
      await _firestore
          .collection(_collectionName)
          .doc(house.id)
          .update(house.toJson());

      print('House updated successfully in Firestore');
      return house;
    } catch (e) {
      print('Error updating house in Firestore: $e');
      throw Exception('Failed to update house: $e');
    }
  }

  @override
  Future<void> deleteHouse(String id) async {
    print('Deleting house with ID: $id');

    try {
      // Delete the house from Firestore
      await _firestore.collection(_collectionName).doc(id).delete();

      print('House deleted successfully from Firestore');
    } catch (e) {
      print('Error deleting house from Firestore: $e');
      throw Exception('Failed to delete house: $e');
    }
  }
}
