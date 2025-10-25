import 'package:freezed_annotation/freezed_annotation.dart';

part 'house.freezed.dart';
part 'house.g.dart';

@freezed
class House with _$House {
  const factory House({
    required String id,
    required String name,
    required double monthlyRent,
    required double securityDeposit,
    required DateTime rentDueDate,
    required bool isAvailable,
    required String description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _House;

  factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);
}
