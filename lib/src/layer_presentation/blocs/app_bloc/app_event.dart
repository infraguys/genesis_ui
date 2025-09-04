part of 'app_bloc.dart';

sealed class AppEvent {
  factory AppEvent.loading() = _Loading;
}

final class _Loading implements AppEvent {}
