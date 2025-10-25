import '../entities/house.dart';

abstract class HouseRepository {
  Future<House> createHouse(House house);
  Future<List<House>> getAllHouses();
  Future<House?> getHouseById(String id);
  Future<House> updateHouse(House house);
  Future<void> deleteHouse(String id);
}
