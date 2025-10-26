// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenantImpl _$$TenantImplFromJson(Map<String, dynamic> json) => _$TenantImpl(
  id: json['id'] as String?,
  name: json['name'] as String,
  houseId: json['houseId'] as String,
  moveInDate: DateTime.parse(json['moveInDate'] as String),
  agreementStartDate: DateTime.parse(json['agreementStartDate'] as String),
  agreementEndDate: DateTime.parse(json['agreementEndDate'] as String),
  rentAmount: (json['rentAmount'] as num).toDouble(),
  securityDeposit: (json['securityDeposit'] as num).toDouble(),
  isActive: json['isActive'] as bool,
  phoneNumber: json['phoneNumber'] as String?,
  email: json['email'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$TenantImplToJson(_$TenantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'houseId': instance.houseId,
      'moveInDate': instance.moveInDate.toIso8601String(),
      'agreementStartDate': instance.agreementStartDate.toIso8601String(),
      'agreementEndDate': instance.agreementEndDate.toIso8601String(),
      'rentAmount': instance.rentAmount,
      'securityDeposit': instance.securityDeposit,
      'isActive': instance.isActive,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
