import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meter_reading.dart';
import 'meter_reading_repository_provider.dart';

final meterReadingListProvider = FutureProvider<List<MeterReading>>((
  ref,
) async {
  final repository = ref.read(meterReadingRepositoryProvider);
  return await repository.getAllMeterReadings();
});

final meterReadingsByHouseProvider =
    FutureProvider.family<List<MeterReading>, String>((ref, houseId) async {
      final repository = ref.read(meterReadingRepositoryProvider);
      return await repository.getMeterReadingsByHouseId(houseId);
    });

final meterReadingsByTypeProvider =
    FutureProvider.family<
      List<MeterReading>,
      ({String houseId, ReadingType readingType})
    >((ref, params) async {
      final repository = ref.read(meterReadingRepositoryProvider);
      return await repository.getMeterReadingsByType(
        params.houseId,
        params.readingType,
      );
    });

final latestMeterReadingProvider =
    FutureProvider.family<
      MeterReading?,
      ({String houseId, ReadingType readingType})
    >((ref, params) async {
      final repository = ref.read(meterReadingRepositoryProvider);
      return await repository.getLatestMeterReading(
        params.houseId,
        params.readingType,
      );
    });

final createMeterReadingProvider =
    StateNotifierProvider<CreateMeterReadingNotifier, AsyncValue<void>>((ref) {
      return CreateMeterReadingNotifier(
        ref.read(meterReadingRepositoryProvider),
      );
    });

class CreateMeterReadingNotifier extends StateNotifier<AsyncValue<void>> {
  final meterReadingRepository;

  CreateMeterReadingNotifier(this.meterReadingRepository)
    : super(const AsyncValue.data(null));

  Future<void> createMeterReading(MeterReading meterReading) async {
    state = const AsyncValue.loading();
    try {
      await meterReadingRepository.createMeterReading(meterReading);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final updateMeterReadingProvider =
    StateNotifierProvider<UpdateMeterReadingNotifier, AsyncValue<void>>((ref) {
      return UpdateMeterReadingNotifier(
        ref.read(meterReadingRepositoryProvider),
      );
    });

class UpdateMeterReadingNotifier extends StateNotifier<AsyncValue<void>> {
  final meterReadingRepository;

  UpdateMeterReadingNotifier(this.meterReadingRepository)
    : super(const AsyncValue.data(null));

  Future<void> updateMeterReading(MeterReading meterReading) async {
    state = const AsyncValue.loading();
    try {
      await meterReadingRepository.updateMeterReading(meterReading);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final deleteMeterReadingProvider =
    StateNotifierProvider<DeleteMeterReadingNotifier, AsyncValue<void>>((ref) {
      return DeleteMeterReadingNotifier(
        ref.read(meterReadingRepositoryProvider),
      );
    });

class DeleteMeterReadingNotifier extends StateNotifier<AsyncValue<void>> {
  final meterReadingRepository;

  DeleteMeterReadingNotifier(this.meterReadingRepository)
    : super(const AsyncValue.data(null));

  Future<void> deleteMeterReading(String meterReadingId) async {
    state = const AsyncValue.loading();
    try {
      await meterReadingRepository.deleteMeterReading(meterReadingId);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
