import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant.freezed.dart';
part 'tenant.g.dart';

@freezed
class Tenant with _$Tenant {
  const factory Tenant({
    String? id,
    required String name,
    required String houseId,
    required DateTime moveInDate,
    required String mostRecentRentAmount,
    required DateTime mostRecentRentDate,
    required double securityDeposit,
    required bool isActive,
    String? aadhaarNumber,
    String? panNumber,
    bool? isAgreementSigned,
    DateTime? agreementSignedDate,
    String? phoneNumber,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Tenant;

  factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);
}
