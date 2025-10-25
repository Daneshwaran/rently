part of 'house_bloc.dart';

abstract class HouseState extends Equatable {
  const HouseState();

  @override
  List<Object> get props => [];
}

class HouseInitial extends HouseState {}

class HouseLoading extends HouseState {}

class HouseCreated extends HouseState {
  final House house;

  const HouseCreated(this.house);

  @override
  List<Object> get props => [house];
}

class HousesLoaded extends HouseState {
  final List<House> houses;

  const HousesLoaded(this.houses);

  @override
  List<Object> get props => [houses];
}

class HouseUpdated extends HouseState {
  final House house;

  const HouseUpdated(this.house);

  @override
  List<Object> get props => [house];
}

class HouseDeleted extends HouseState {
  final String houseId;

  const HouseDeleted(this.houseId);

  @override
  List<Object> get props => [houseId];
}

class HouseError extends HouseState {
  final String message;

  const HouseError(this.message);

  @override
  List<Object> get props => [message];
}
