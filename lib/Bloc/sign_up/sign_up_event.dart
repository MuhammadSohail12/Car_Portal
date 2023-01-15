part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class TheSignUpEvent extends SignUpEvent {
  final String userName;
  final int phoneNumber;
  final String email;
  final String password;

  TheSignUpEvent(
      {required this.userName,
      required this.phoneNumber,
      required this.email,
      required this.password});
}
