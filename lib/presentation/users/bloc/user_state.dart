part of 'user_bloc.dart';

abstract class UserState {}


class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserCreated extends UserState {}

class UsersLoaded extends UserState {
  final List<UserModel> users;

  UsersLoaded({required this.users});
}


class UserError extends UserState {
  final String message;

  UserError(this.message);

}