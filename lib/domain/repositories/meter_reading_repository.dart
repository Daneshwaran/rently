import '../entities/meter_reading.dart';

abstract class MeterReadingRepository {
  Future<MeterReading> createMeterReading(MeterReading meterReading);
  Future<List<MeterReading>> getAllMeterReadings();
  Future<List<MeterReading>> getMeterReadingsByHouseId(String houseId);
  Future<List<MeterReading>> getMeterReadingsByType(
    String houseId,
    ReadingType readingType,
  );
  Future<MeterReading?> getLatestMeterReading(
    String houseId,
    ReadingType readingType,
  );
  Future<MeterReading?> getMeterReadingById(String id);
  Future<MeterReading> updateMeterReading(MeterReading meterReading);
  Future<void> deleteMeterReading(String id);
}
