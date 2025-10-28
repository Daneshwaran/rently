import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/house.dart';
import 'house_repository_provider.dart';

final houseListProvider = FutureProvider<List<House>>((ref) async {
  final repository = ref.read(houseRepositoryProvider);
  return await repository.getAllHouses();
});

final houseProvider = FutureProvider.family<House?, String>((
  ref,
  houseId,
) async {
  final repository = ref.read(houseRepositoryProvider);
  return await repository.getHouseById(houseId);
});

final createHouseProvider =
    StateNotifierProvider<CreateHouseNotifier, AsyncValue<void>>((ref) {
      return CreateHouseNotifier(ref.read(houseRepositoryProvider));
    });

class CreateHouseNotifier extends StateNotifier<AsyncValue<void>> {
  final houseRepository;

  CreateHouseNotifier(this.houseRepository)
    : super(const AsyncValue.data(null));

  Future<void> createHouse(House house) async {
    state = const AsyncValue.loading();
    try {
      await houseRepository.createHouse(house);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final updateHouseProvider =
    StateNotifierProvider<UpdateHouseNotifier, AsyncValue<void>>((ref) {
      return UpdateHouseNotifier(ref.read(houseRepositoryProvider));
    });

class UpdateHouseNotifier extends StateNotifier<AsyncValue<void>> {
  final houseRepository;

  UpdateHouseNotifier(this.houseRepository)
    : super(const AsyncValue.data(null));

  Future<void> updateHouse(House house) async {
    state = const AsyncValue.loading();
    try {
      await houseRepository.updateHouse(house);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final deleteHouseProvider =
    StateNotifierProvider<DeleteHouseNotifier, AsyncValue<void>>((ref) {
      return DeleteHouseNotifier(ref.read(houseRepositoryProvider));
    });

class DeleteHouseNotifier extends StateNotifier<AsyncValue<void>> {
  final houseRepository;

  DeleteHouseNotifier(this.houseRepository)
    : super(const AsyncValue.data(null));

  Future<void> deleteHouse(String houseId) async {
    state = const AsyncValue.loading();
    try {
      await houseRepository.deleteHouse(houseId);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
