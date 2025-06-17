part of 'user_bloc.dart';

abstract class UserEvent {}


class GetAllUsersEvent extends UserEvent {
  final String userId;

  GetAllUsersEvent(this.userId);
}