enum ReadingType { electricity, water }

class MeterReading {
  final String id;
  final String houseId;
  final ReadingType readingType;
  final double currentReading;
  final double previousReading;
  final DateTime readingDate;
  final double ratePerUnit;
  final double calculatedAmount;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MeterReading({
    required this.id,
    required this.houseId,
    required this.readingType,
    required this.currentReading,
    required this.previousReading,
    required this.readingDate,
    required this.ratePerUnit,
    required this.calculatedAmount,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory MeterReading.fromJson(Map<String, dynamic> json) {
    return MeterReading(
      id: json['id'] as String,
      houseId: json['houseId'] as String,
      readingType: ReadingType.values.firstWhere(
        (e) => e.name == json['readingType'],
        orElse: () => ReadingType.electricity,
      ),
      currentReading: (json['currentReading'] as num).toDouble(),
      previousReading: (json['previousReading'] as num).toDouble(),
      readingDate: DateTime.parse(json['readingDate'] as String),
      ratePerUnit: (json['ratePerUnit'] as num).toDouble(),
      calculatedAmount: (json['calculatedAmount'] as num).toDouble(),
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
      'houseId': houseId,
      'readingType': readingType.name,
      'currentReading': currentReading,
      'previousReading': previousReading,
      'readingDate': readingDate.toIso8601String(),
      'ratePerUnit': ratePerUnit,
      'calculatedAmount': calculatedAmount,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  MeterReading copyWith({
    String? id,
    String? houseId,
    ReadingType? readingType,
    double? currentReading,
    double? previousReading,
    DateTime? readingDate,
    double? ratePerUnit,
    double? calculatedAmount,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MeterReading(
      id: id ?? this.id,
      houseId: houseId ?? this.houseId,
      readingType: readingType ?? this.readingType,
      currentReading: currentReading ?? this.currentReading,
      previousReading: previousReading ?? this.previousReading,
      readingDate: readingDate ?? this.readingDate,
      ratePerUnit: ratePerUnit ?? this.ratePerUnit,
      calculatedAmount: calculatedAmount ?? this.calculatedAmount,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MeterReading &&
        other.id == id &&
        other.houseId == houseId &&
        other.readingType == readingType &&
        other.currentReading == currentReading &&
        other.previousReading == previousReading &&
        other.readingDate == readingDate &&
        other.ratePerUnit == ratePerUnit &&
        other.calculatedAmount == calculatedAmount &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      houseId,
      readingType,
      currentReading,
      previousReading,
      readingDate,
      ratePerUnit,
      calculatedAmount,
      description,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'MeterReading(id: $id, houseId: $houseId, readingType: $readingType, currentReading: $currentReading, previousReading: $previousReading, readingDate: $readingDate, ratePerUnit: $ratePerUnit, calculatedAmount: $calculatedAmount, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
