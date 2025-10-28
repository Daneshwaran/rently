enum PaymentType { rent, electricity, water, partial }

class Payment {
  final String id;
  final String tenantId;
  final String houseId;
  final double amount;
  final DateTime paymentDate;
  final PaymentType paymentType;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Payment({
    required this.id,
    required this.tenantId,
    required this.houseId,
    required this.amount,
    required this.paymentDate,
    required this.paymentType,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String,
      tenantId: json['tenantId'] as String,
      houseId: json['houseId'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      paymentType: PaymentType.values.firstWhere(
        (e) => e.name == json['paymentType'],
        orElse: () => PaymentType.rent,
      ),
      description: json['description'] as String?,
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
      'tenantId': tenantId,
      'houseId': houseId,
      'amount': amount,
      'paymentDate': paymentDate.toIso8601String(),
      'paymentType': paymentType.name,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Payment copyWith({
    String? id,
    String? tenantId,
    String? houseId,
    double? amount,
    DateTime? paymentDate,
    PaymentType? paymentType,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Payment(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      houseId: houseId ?? this.houseId,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentType: paymentType ?? this.paymentType,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Payment &&
        other.id == id &&
        other.tenantId == tenantId &&
        other.houseId == houseId &&
        other.amount == amount &&
        other.paymentDate == paymentDate &&
        other.paymentType == paymentType &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      tenantId,
      houseId,
      amount,
      paymentDate,
      paymentType,
      description,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'Payment(id: $id, tenantId: $tenantId, houseId: $houseId, amount: $amount, paymentDate: $paymentDate, paymentType: $paymentType, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
