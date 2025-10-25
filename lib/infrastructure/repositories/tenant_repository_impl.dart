import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/tenant.dart';
import '../../domain/repositories/tenant_repository.dart';

class TenantRepositoryImpl implements TenantRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'tenants';

  // Helper method to convert Firestore data to proper format
  Map<String, dynamic> _convertFirestoreData(Map<String, dynamic> data) {
    final convertedData = Map<String, dynamic>.from(data);

    // Convert Timestamp to DateTime, then to ISO string for JSON serialization
    if (convertedData['moveInDate'] is Timestamp) {
      final dateTime = (convertedData['moveInDate'] as Timestamp).toDate();
      convertedData['moveInDate'] = dateTime.toIso8601String();
    }
    if (convertedData['createdAt'] is Timestamp) {
      final dateTime = (convertedData['createdAt'] as Timestamp).toDate();
      convertedData['createdAt'] = dateTime.toIso8601String();
    }
    if (convertedData['updatedAt'] is Timestamp) {
      final dateTime = (convertedData['updatedAt'] as Timestamp).toDate();
      convertedData['updatedAt'] = dateTime.toIso8601String();
    }

    // Handle null values for required numeric fields
    if (convertedData['rentAmount'] == null) {
      convertedData['rentAmount'] = 0.0;
    }
    if (convertedData['securityDeposit'] == null) {
      convertedData['securityDeposit'] = 0.0;
    }
    if (convertedData['isActive'] == null) {
      convertedData['isActive'] = true;
    }

    // Handle type conversions for fields that might be stored as different types
    if (convertedData['id'] is int) {
      convertedData['id'] = convertedData['id'].toString();
    }
    if (convertedData['houseId'] is int) {
      convertedData['houseId'] = convertedData['houseId'].toString();
    }
    if (convertedData['phoneNumber'] is int) {
      convertedData['phoneNumber'] = convertedData['phoneNumber'].toString();
    }

    return convertedData;
  }

  @override
  Future<Tenant> createTenant(Tenant tenant) async {
    try {
      log('Creating tenant: ${tenant.name}');
      log('Tenant details: ${tenant.toJson()}');

      await _firestore
          .collection(_collectionName)
          .doc(tenant.id)
          .set(tenant.toJson());

      log('Tenant saved to Firestore successfully with ID: ${tenant.id}');
      return tenant;
    } catch (e) {
      log('Error saving tenant to Firestore: $e');
      rethrow;
    }
  }

  @override
  Future<List<Tenant>> getAllTenants() async {
    try {
      log('Getting all tenants from Firestore');
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .orderBy('createdAt', descending: true)
          .get();
      final tenants = querySnapshot.docs
          .map((doc) => Tenant.fromJson(_convertFirestoreData(doc.data())))
          .toList();
      log('Total tenants in Firestore: ${tenants.length}');
      return tenants;
    } catch (e) {
      log('Error getting all tenants from Firestore: $e');
      rethrow;
    }
  }

  @override
  Future<Tenant?> getTenantById(String id) async {
    try {
      log('Getting tenant by ID: $id from Firestore');
      final docSnapshot = await _firestore
          .collection(_collectionName)
          .doc(id)
          .get();
      if (docSnapshot.exists) {
        final tenant = Tenant.fromJson(
          _convertFirestoreData(docSnapshot.data()!),
        );
        log('Tenant found: ${tenant.name}');
        return tenant;
      } else {
        log('Tenant not found with ID: $id in Firestore');
        return null;
      }
    } catch (e) {
      log('Error getting tenant by ID from Firestore: $e');
      rethrow;
    }
  }

  @override
  Future<List<Tenant>> getTenantsByHouseId(String houseId) async {
    try {
      log('Getting tenants by house ID: $houseId from Firestore');
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('houseId', isEqualTo: houseId)
          .get();

      final List<Tenant> tenants = querySnapshot.docs
          .map((doc) => Tenant.fromJson(_convertFirestoreData(doc.data())))
          .toList();
      log('Found ${tenants.length} tenants for house ID: $houseId');
      return tenants;
    } catch (e) {
      log('Error getting tenants by house ID from Firestore: $e');
      rethrow;
    }
  }

  @override
  Future<Tenant> updateTenant(Tenant tenant) async {
    try {
      log('Updating tenant: ${tenant.name} in Firestore');
      log('Updated tenant details: ${tenant.toJson()}');

      await _firestore
          .collection(_collectionName)
          .doc(tenant.id)
          .update(tenant.toJson());

      log('Tenant updated successfully in Firestore');
      return tenant;
    } catch (e) {
      log('Error updating tenant in Firestore: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTenant(String id) async {
    try {
      log('Deleting tenant with ID: $id from Firestore');

      await _firestore.collection(_collectionName).doc(id).delete();

      log('Tenant deleted successfully from Firestore');
    } catch (e) {
      log('Error deleting tenant from Firestore: $e');
      rethrow;
    }
  }
}
