import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/repositories/meter_reading_repository_impl.dart';
import '../../domain/repositories/meter_reading_repository.dart';

final meterReadingRepositoryProvider = Provider<MeterReadingRepository>((ref) {
  return MeterReadingRepositoryImpl();
});
