import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/house.dart';
import '../../domain/repositories/house_repository.dart';

part 'house_event.dart';
part 'house_state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  final HouseRepository _houseRepository;

  HouseBloc({required HouseRepository houseRepository})
    : _houseRepository = houseRepository,
      super(HouseInitial()) {
    on<CreateHouseEvent>(_onCreateHouse);
    on<GetAllHousesEvent>(_onGetAllHouses);
    on<UpdateHouseEvent>(_onUpdateHouse);
    on<DeleteHouseEvent>(_onDeleteHouse);
  }

  Future<void> _onCreateHouse(
    CreateHouseEvent event,
    Emitter<HouseState> emit,
  ) async {
    emit(HouseLoading());
    try {
      print('Creating house: ${event.house.toJson()}');
      final house = await _houseRepository.createHouse(event.house);
      emit(HouseCreated(house));
    } catch (e) {
      emit(HouseError('Failed to create house: ${e.toString()}'));
    }
  }

  Future<void> _onGetAllHouses(
    GetAllHousesEvent event,
    Emitter<HouseState> emit,
  ) async {
    emit(HouseLoading());
    try {
      final houses = await _houseRepository.getAllHouses();
      emit(HousesLoaded(houses));
    } catch (e) {
      emit(HouseError('Failed to load houses: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateHouse(
    UpdateHouseEvent event,
    Emitter<HouseState> emit,
  ) async {
    emit(HouseLoading());
    try {
      final house = await _houseRepository.updateHouse(event.house);
      emit(HouseUpdated(house));
    } catch (e) {
      emit(HouseError('Failed to update house: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteHouse(
    DeleteHouseEvent event,
    Emitter<HouseState> emit,
  ) async {
    emit(HouseLoading());
    try {
      await _houseRepository.deleteHouse(event.houseId);
      emit(HouseDeleted(event.houseId));
    } catch (e) {
      emit(HouseError('Failed to delete house: ${e.toString()}'));
    }
  }
}
