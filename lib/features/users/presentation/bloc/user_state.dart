part of 'user_bloc.dart';

@immutable
sealed class UserState {}
sealed class UserActionState extends UserState {}

final class UserInitial extends UserState {}

class UserLoadedState extends UserState {
  final List<UserEntity> users;
  UserLoadedState(this.users);
}

class UserErrorState extends UserState {
  final Failure failure;
  UserErrorState(this.failure);
}

class NavigateToScreenActionState extends UserActionState {
  final CupertinoPageRoute route;
  NavigateToScreenActionState(this.route);
}