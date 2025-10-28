import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/meter_reading.dart';
import '../../domain/repositories/meter_reading_repository.dart';

class MeterReadingRepositoryImpl implements MeterReadingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'meter_readings';

  @override
  Future<MeterReading> createMeterReading(MeterReading meterReading) async {
    try {
      log('Creating meter reading: ${meterReading.id}');
      await _firestore
          .collection(_collectionName)
          .doc(meterReading.id)
          .set(meterReading.toJson());

      log(
        'Meter reading saved to Firestore successfully with ID: ${meterReading.id}',
      );
      return meterReading;
    } catch (e) {
      log('Error saving meter reading to Firestore: $e');
      throw Exception('Failed to save meter reading: $e');
    }
  }

  @override
  Future<List<MeterReading>> getAllMeterReadings() async {
    try {
      log('Getting all meter readings from Firestore');
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .orderBy('readingDate', descending: true)
          .get();

      final meterReadings = querySnapshot.docs
          .map((doc) => MeterReading.fromJson(doc.data()))
          .toList();

      log('Total meter readings in Firestore: ${meterReadings.length}');
      return meterReadings;
    } catch (e) {
      log('Error getting all meter readings from Firestore: $e');
      throw Exception('Failed to get meter readings: $e');
    }
  }

  @override
  Future<List<MeterReading>> getMeterReadingsByHouseId(String houseId) async {
    try {
      log('Getting meter readings by house ID: $houseId');
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('houseId', isEqualTo: houseId)
          .orderBy('readingDate', descending: true)
          .get();

      final meterReadings = querySnapshot.docs
          .map((doc) => MeterReading.fromJson(doc.data()))
          .toList();

      log(
        'Found ${meterReadings.length} meter readings for house ID: $houseId',
      );
      return meterReadings;
    } catch (e) {
      log('Error getting meter readings by house ID: $e');
      throw Exception('Failed to get meter readings by house ID: $e');
    }
  }

  @override
  Future<List<MeterReading>> getMeterReadingsByType(
    String houseId,
    ReadingType readingType,
  ) async {
    try {
      log(
        'Getting meter readings by type: ${readingType.name} for house: $houseId',
      );
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('houseId', isEqualTo: houseId)
          .where('readingType', isEqualTo: readingType.name)
          .orderBy('readingDate', descending: true)
          .get();

      final meterReadings = querySnapshot.docs
          .map((doc) => MeterReading.fromJson(doc.data()))
          .toList();

      log(
        'Found ${meterReadings.length} ${readingType.name} readings for house ID: $houseId',
      );
      return meterReadings;
    } catch (e) {
      log('Error getting meter readings by type: $e');
      throw Exception('Failed to get meter readings by type: $e');
    }
  }

  @override
  Future<MeterReading?> getLatestMeterReading(
    String houseId,
    ReadingType readingType,
  ) async {
    try {
      log('Getting latest ${readingType.name} reading for house: $houseId');
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('houseId', isEqualTo: houseId)
          .where('readingType', isEqualTo: readingType.name)
          .orderBy('readingDate', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final meterReading = MeterReading.fromJson(
          querySnapshot.docs.first.data(),
        );
        log('Latest ${readingType.name} reading found: ${meterReading.id}');
        return meterReading;
      } else {
        log('No ${readingType.name} readings found for house ID: $houseId');
        return null;
      }
    } catch (e) {
      log('Error getting latest meter reading: $e');
      throw Exception('Failed to get latest meter reading: $e');
    }
  }

  @override
  Future<MeterReading?> getMeterReadingById(String id) async {
    try {
      log('Getting meter reading by ID: $id');
      final docSnapshot = await _firestore
          .collection(_collectionName)
          .doc(id)
          .get();

      if (docSnapshot.exists) {
        final meterReading = MeterReading.fromJson(docSnapshot.data()!);
        log('Meter reading found: ${meterReading.id}');
        return meterReading;
      } else {
        log('Meter reading not found with ID: $id');
        return null;
      }
    } catch (e) {
      log('Error getting meter reading by ID: $e');
      throw Exception('Failed to get meter reading: $e');
    }
  }

  @override
  Future<MeterReading> updateMeterReading(MeterReading meterReading) async {
    try {
      log('Updating meter reading: ${meterReading.id}');
      await _firestore
          .collection(_collectionName)
          .doc(meterReading.id)
          .update(meterReading.toJson());

      log('Meter reading updated successfully in Firestore');
      return meterReading;
    } catch (e) {
      log('Error updating meter reading in Firestore: $e');
      throw Exception('Failed to update meter reading: $e');
    }
  }

  @override
  Future<void> deleteMeterReading(String id) async {
    try {
      log('Deleting meter reading with ID: $id');
      await _firestore.collection(_collectionName).doc(id).delete();
      log('Meter reading deleted successfully from Firestore');
    } catch (e) {
      log('Error deleting meter reading from Firestore: $e');
      throw Exception('Failed to delete meter reading: $e');
    }
  }
}
