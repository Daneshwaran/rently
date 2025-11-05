class Payment {
  final String id;
  final String tenantId;
  final String houseId;
  final double paidAmount;
  final double totalAmount;
  final double remainingAmount;
  final DateTime paymentDate;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Payment({
    required this.id,
    required this.tenantId,
    required this.houseId,
    required this.paidAmount,
    required this.totalAmount,
    required this.remainingAmount,
    required this.paymentDate,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String,
      tenantId: json['tenantId'] as String,
      houseId: json['houseId'] as String,
      paidAmount: (json['paidAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      remainingAmount: (json['remainingAmount'] as num).toDouble(),
      paymentDate: DateTime.parse(json['paymentDate'] as String),
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
      'paidAmount': paidAmount,
      'totalAmount': totalAmount,
      'remainingAmount': remainingAmount,
      'paymentDate': paymentDate.toIso8601String(),
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Payment copyWith({
    String? id,
    String? tenantId,
    String? houseId,
    double? paidAmount,
    double? totalAmount,
    double? remainingAmount,
    DateTime? paymentDate,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Payment(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      houseId: houseId ?? this.houseId,
      paidAmount: paidAmount ?? this.paidAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      paymentDate: paymentDate ?? this.paymentDate,
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
        other.paidAmount == paidAmount &&
        other.paymentDate == paymentDate &&
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
      paidAmount,
      totalAmount,
      remainingAmount,
      paymentDate,
      description,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'Payment(id: $id, tenantId: $tenantId, houseId: $houseId, paidAmount: $paidAmount, totalAmount: $totalAmount, remainingAmount: $remainingAmount, paymentDate: $paymentDate, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
