import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:car_portal/Models/usermodel.dart';
import 'package:car_portal/services/auth_services.dart';
import 'package:car_portal/services/db_helper.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      // TODO: implement event handler

      try {
        if (event is TheSignUpEvent) {
          emit.call(SignUpLoading());

          SembastDb db = SembastDb();
          await db.init();
          await db
              .signup(UserModel( event.userName, event.phoneNumber,
                  event.email, event.password))
              .then((value) {
            value == 0
                ? emit.call(SignUpInitial())
                : emit.call(SignupSuccess());
          });
          emit.call(SignUpInitial());
        } else {
          emit.call(SignUpInitial());
        }
      } catch (e) {
        print('exception  $e');
        emit.call(SignUpInitial());
      }
    });
  }
}
