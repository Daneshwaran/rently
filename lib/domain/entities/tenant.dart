class Tenant {
  final String? id;
  final String name;
  final num rentAmount;
  final num securityDeposit;
  final String houseId;
  final DateTime moveInDate;
  final DateTime agreementStartDate;
  final DateTime agreementEndDate;
  final String phoneNumber;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Tenant({
    this.id,
    required this.name,
    required this.rentAmount,
    required this.securityDeposit,
    required this.houseId,
    required this.moveInDate,
    required this.agreementStartDate,
    required this.agreementEndDate,
    required this.phoneNumber,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      id: json['id'] as String?,
      name: json['name'] as String,
      rentAmount: json['rentAmount'] as num,
      securityDeposit: json['securityDeposit'] as num,
      houseId: json['houseId'] as String,
      moveInDate: DateTime.parse(json['moveInDate'] as String),
      agreementStartDate: DateTime.parse(json['agreementStartDate'] as String),
      agreementEndDate: DateTime.parse(json['agreementEndDate'] as String),
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rentAmount': rentAmount,
      'securityDeposit': securityDeposit,
      'houseId': houseId,
      'moveInDate': moveInDate.toIso8601String(),
      'agreementStartDate': agreementStartDate.toIso8601String(),
      'agreementEndDate': agreementEndDate.toIso8601String(),
      'phoneNumber': phoneNumber,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Tenant copyWith({
    String? id,
    String? name,
    num? rentAmount,
    num? securityDeposit,
    String? houseId,
    DateTime? moveInDate,
    DateTime? agreementStartDate,
    DateTime? agreementEndDate,
    String? phoneNumber,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Tenant(
      id: id ?? this.id,
      name: name ?? this.name,
      rentAmount: rentAmount ?? this.rentAmount,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      houseId: houseId ?? this.houseId,
      moveInDate: moveInDate ?? this.moveInDate,
      agreementStartDate: agreementStartDate ?? this.agreementStartDate,
      agreementEndDate: agreementEndDate ?? this.agreementEndDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Tenant(id: $id, name: $name, rentAmount: $rentAmount, securityDeposit: $securityDeposit, houseId: $houseId, moveInDate: $moveInDate, agreementStartDate: $agreementStartDate, agreementEndDate: $agreementEndDate, phoneNumber: $phoneNumber, email: $email, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Tenant &&
        other.id == id &&
        other.name == name &&
        other.rentAmount == rentAmount &&
        other.securityDeposit == securityDeposit &&
        other.houseId == houseId &&
        other.moveInDate == moveInDate &&
        other.agreementStartDate == agreementStartDate &&
        other.agreementEndDate == agreementEndDate &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      rentAmount,
      securityDeposit,
      houseId,
      moveInDate,
      agreementStartDate,
      agreementEndDate,
      phoneNumber,
      email,
      createdAt,
      updatedAt,
    );
  }
}
