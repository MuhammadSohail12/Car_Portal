part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class TheSignInEvent extends SignInEvent {
  final String email;
  final String password;

  TheSignInEvent({required this.email, required this.password});
}
