// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HouseImpl _$$HouseImplFromJson(Map<String, dynamic> json) => _$HouseImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  monthlyRent: (json['monthlyRent'] as num).toDouble(),
  securityDeposit: (json['securityDeposit'] as num).toDouble(),
  rentDueDate: DateTime.parse(json['rentDueDate'] as String),
  isAvailable: json['isAvailable'] as bool,
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$HouseImplToJson(_$HouseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'monthlyRent': instance.monthlyRent,
      'securityDeposit': instance.securityDeposit,
      'rentDueDate': instance.rentDueDate.toIso8601String(),
      'isAvailable': instance.isAvailable,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
