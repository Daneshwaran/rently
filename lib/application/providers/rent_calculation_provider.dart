import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/rent_calculation.dart';
import '../../domain/entities/house.dart';
import '../../domain/entities/payment.dart';
import '../../domain/entities/meter_reading.dart';
import 'house_provider.dart';
import 'payment_provider.dart';
import 'meter_reading_provider.dart';

final rentCalculationProvider = FutureProvider.family<RentCalculation, String>((
  ref,
  houseId,
) async {
  final houseAsync = ref.watch(houseProvider(houseId));
  final paymentsAsync = ref.watch(paymentsByHouseProvider(houseId));
  final electricityReadingAsync = ref.watch(
    latestMeterReadingProvider((
      houseId: houseId,
      readingType: ReadingType.electricity,
    )),
  );
  final waterReadingAsync = ref.watch(
    latestMeterReadingProvider((
      houseId: houseId,
      readingType: ReadingType.water,
    )),
  );

  return houseAsync.when(
    data: (house) {
      if (house == null) {
        return const RentCalculation(
          monthlyRent: 0,
          rentArrears: 0,
          electricityBill: 0,
          waterBill: 0,
        );
      }

      // Calculate rent arrears
      final rentArrears = paymentsAsync.when(
        data: (payments) => _calculateRentArrears(house, payments),
        loading: () => 0.0,
        error: (_, __) => 0.0,
      );

      // Get electricity bill
      final electricityBill = electricityReadingAsync.when(
        data: (reading) => reading?.calculatedAmount ?? 0.0,
        loading: () => 0.0,
        error: (_, __) => 0.0,
      );

      // Get water bill
      final waterBill = waterReadingAsync.when(
        data: (reading) => reading?.calculatedAmount ?? 0.0,
        loading: () => 0.0,
        error: (_, __) => 0.0,
      );

      return RentCalculation(
        monthlyRent: 15000,
        rentArrears: rentArrears,
        electricityBill: electricityBill,
        waterBill: waterBill,
      );
    },
    loading: () => const RentCalculation(
      monthlyRent: 0,
      rentArrears: 0,
      electricityBill: 0,
      waterBill: 0,
    ),
    error: (_, __) => const RentCalculation(
      monthlyRent: 0,
      rentArrears: 0,
      electricityBill: 0,
      waterBill: 0,
    ),
  );
});

double _calculateRentArrears(House house, List<Payment> payments) {
  if (payments.isEmpty) {
    // If no payments, calculate from rent due date
    final now = DateTime.now();
    final monthsSinceDue = _monthsBetween(DateTime(2025, 1, 10), now);
    return 15000.0 * monthsSinceDue;
  }

  // Sort payments by date (most recent first)
  payments.sort((a, b) => b.paymentDate.compareTo(a.paymentDate));

  final now = DateTime.now();

  // Calculate total rent paid
  final totalRentPaid = payments.fold(
    0.0,
    (sum, payment) => sum + payment.paidAmount,
  );

  // Calculate total months that should have been paid
  final monthsSinceStart = _monthsBetween(DateTime(2025, 1, 10), now);
  final totalRentDue = 15000.0 * monthsSinceStart;

  // Calculate arrears
  final arrears = totalRentDue - totalRentPaid;
  return arrears > 0 ? arrears : 0.0;
}

int _monthsBetween(DateTime start, DateTime end) {
  return (end.year - start.year) * 12 + (end.month - start.month);
}
