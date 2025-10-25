part of 'house_bloc.dart';

abstract class HouseEvent extends Equatable {
  const HouseEvent();

  @override
  List<Object> get props => [];
}

class CreateHouseEvent extends HouseEvent {
  final House house;

  const CreateHouseEvent({required this.house});

  @override
  List<Object> get props => [house];
}

class GetAllHousesEvent extends HouseEvent {
  const GetAllHousesEvent();
}

class UpdateHouseEvent extends HouseEvent {
  final House house;

  const UpdateHouseEvent({required this.house});

  @override
  List<Object> get props => [house];
}

class DeleteHouseEvent extends HouseEvent {
  final String houseId;

  const DeleteHouseEvent({required this.houseId});

  @override
  List<Object> get props => [houseId];
}
