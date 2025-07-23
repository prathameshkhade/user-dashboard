part of 'user_bloc.dart';

@immutable
sealed class UserState {}
sealed class UserActionState extends UserState {}

enum SortType { none, ascending, descending }

final class UserInitial extends UserState {}

class UserLoadedState extends UserState {
  final List<UserEntity> users;
  final List<UserEntity> originalUsers; // Keep track of original users for search
  final SortType currentSortType;
  UserLoadedState(this.users, this.originalUsers, this.currentSortType);
}

class UserErrorState extends UserState {
  final Failure failure;
  UserErrorState(this.failure);
}

class NavigateToScreenActionState extends UserActionState {
  final CupertinoPageRoute route;
  NavigateToScreenActionState(this.route);
}