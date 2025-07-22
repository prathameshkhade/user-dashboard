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