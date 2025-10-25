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
  mostRecentRentAmount: json['mostRecentRentAmount'] as String,
  mostRecentRentDate: DateTime.parse(json['mostRecentRentDate'] as String),
  securityDeposit: (json['securityDeposit'] as num).toDouble(),
  isActive: json['isActive'] as bool,
  aadhaarNumber: json['aadhaarNumber'] as String?,
  panNumber: json['panNumber'] as String?,
  isAgreementSigned: json['isAgreementSigned'] as bool?,
  agreementSignedDate: json['agreementSignedDate'] == null
      ? null
      : DateTime.parse(json['agreementSignedDate'] as String),
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
      'mostRecentRentAmount': instance.mostRecentRentAmount,
      'mostRecentRentDate': instance.mostRecentRentDate.toIso8601String(),
      'securityDeposit': instance.securityDeposit,
      'isActive': instance.isActive,
      'aadhaarNumber': instance.aadhaarNumber,
      'panNumber': instance.panNumber,
      'isAgreementSigned': instance.isAgreementSigned,
      'agreementSignedDate': instance.agreementSignedDate?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
