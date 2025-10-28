class RentCalculation {
  final double monthlyRent;
  final double rentArrears;
  final double electricityBill;
  final double waterBill;

  const RentCalculation({
    required this.monthlyRent,
    required this.rentArrears,
    required this.electricityBill,
    required this.waterBill,
  });

  double get totalRent =>
      monthlyRent + rentArrears + electricityBill + waterBill;

  factory RentCalculation.fromJson(Map<String, dynamic> json) {
    return RentCalculation(
      monthlyRent: (json['monthlyRent'] as num).toDouble(),
      rentArrears: (json['rentArrears'] as num).toDouble(),
      electricityBill: (json['electricityBill'] as num).toDouble(),
      waterBill: (json['waterBill'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monthlyRent': monthlyRent,
      'rentArrears': rentArrears,
      'electricityBill': electricityBill,
      'waterBill': waterBill,
    };
  }

  RentCalculation copyWith({
    double? monthlyRent,
    double? rentArrears,
    double? electricityBill,
    double? waterBill,
  }) {
    return RentCalculation(
      monthlyRent: monthlyRent ?? this.monthlyRent,
      rentArrears: rentArrears ?? this.rentArrears,
      electricityBill: electricityBill ?? this.electricityBill,
      waterBill: waterBill ?? this.waterBill,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RentCalculation &&
        other.monthlyRent == monthlyRent &&
        other.rentArrears == rentArrears &&
        other.electricityBill == electricityBill &&
        other.waterBill == waterBill;
  }

  @override
  int get hashCode {
    return Object.hash(monthlyRent, rentArrears, electricityBill, waterBill);
  }

  @override
  String toString() {
    return 'RentCalculation(monthlyRent: $monthlyRent, rentArrears: $rentArrears, electricityBill: $electricityBill, waterBill: $waterBill)';
  }
}
