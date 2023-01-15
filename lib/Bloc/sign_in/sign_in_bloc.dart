import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:car_portal/services/db_helper.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      // TODO: implement event handler

      try{

        if(event is TheSignInEvent){

          emit.call(SignInLoading());


          SembastDb db=SembastDb();
          await db.init();
          await db.signin(event.email, event.password).then((value){
            value? emit.call(SignInSuccess()):emit.call(SignInInitial());
          });
          emit.call(SignInInitial());

        }else{

          emit.call(SignInInitial());

        }



      }catch(e){
        print('exception  $e');
        emit.call(SignInInitial());



      }

    });
  }
}
