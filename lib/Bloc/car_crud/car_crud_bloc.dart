import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:car_portal/Models/carmodel.dart';
import 'package:car_portal/services/db_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'car_crud_event.dart';
part 'car_crud_state.dart';

class CarCrudBloc extends Bloc<CarCrudEvent, CarCrudState> {
  SembastDb db = SembastDb();
  CarCrudBloc() : super(CarDataLoading()) {
    // ignore: void_checks
    on<CarCrudEvent>((event, emit) async {
      // TODO: implement event handler

      try {
         if (event is CarDataLoadEvent) {
          // Indicating that fruits are being loaded - display progress indicator.
          emit.call(CarDataLoading());
           _reloadCarsData();
        } else if (event is CarDataInsert) {

          await db.init();
          await db.cardataInsert(CarModel(
               event.make, event.color, event.model, event.registeration));
           _reloadCarsData();
        } else if (event is CarDataUpdated) {
          await db.init();

          print('22');
          await db.carUpdateData(event.updatedCarData);
           _reloadCarsData();
        } else if (event is CarDataDeleted) {
          await db.init();
          await db.carDeletedData(event.deletedCarData);
           _reloadCarsData();
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
  }

   _reloadCarsData() async {
    await db.init();
    final cardata = await db.getAllCarData();
    final totalCarsValue=    await db.countRegisterCar();

    // Yielding a state bundled with the Fruits from the database.
    emit.call(CarDataLoaded(carModel: cardata,totalCars: totalCarsValue));
  }
}
