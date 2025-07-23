part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class RefreshUsersEvent extends UserEvent {
  final Completer<void> completer;
  RefreshUsersEvent({required this.completer});
}

class NavigateToScreenEvent extends UserEvent {
  final Widget destination;
  NavigateToScreenEvent(this.destination);
}

class SearchUsersEvent extends UserEvent {
  final String query;
  SearchUsersEvent({required this.query});
}

class SortUsersEvent extends UserEvent {
  // true for A-Z, false for Z-A
  final bool ascending;
  SortUsersEvent({required this.ascending});
}