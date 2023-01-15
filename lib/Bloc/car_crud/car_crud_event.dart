part of 'car_crud_bloc.dart';

@immutable
abstract class CarCrudEvent {}

class CarDataLoadEvent extends CarCrudEvent {}

class CarDataInsert extends CarCrudEvent {
  final String make;
  final String model;
  final String registeration;
  final String color;

  CarDataInsert(
      {required this.make,
      required this.model,
      required this.registeration,
      required this.color});
}

class CarDataUpdated extends CarCrudEvent {
  final CarModel updatedCarData;

  CarDataUpdated({required this.updatedCarData});
}

class CarDataDeleted extends CarCrudEvent {
  final CarModel deletedCarData;

  CarDataDeleted({required this.deletedCarData});
}
