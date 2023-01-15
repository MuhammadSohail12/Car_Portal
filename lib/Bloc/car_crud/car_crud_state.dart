part of 'car_crud_bloc.dart';

@immutable
abstract class CarCrudState {}

class CarDataLoading extends CarCrudState {}
class CarDataLoaded extends CarCrudState {

final List<CarModel> carModel;
final int totalCars;

  CarDataLoaded({required this.totalCars, required this.carModel});


}

