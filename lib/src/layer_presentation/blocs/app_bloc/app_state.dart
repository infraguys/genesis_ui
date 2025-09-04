part of 'app_bloc.dart';

sealed class AppState {
  factory AppState.init() = AppInitState;

  factory AppState.loading() = AppLoadingState;

  factory AppState.initialized() = AppInitializedState;
}

final class AppInitState implements AppState {}

final class AppLoadingState implements AppState {}

final class AppInitializedState implements AppState {}
