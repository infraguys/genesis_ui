part of 'project_bloc.dart';

sealed class ProjectEvent {
  factory ProjectEvent.create({
    required String name,
    required String description,
    required String organization,
  }) = _CreateProjectEvent;
}

final class _CreateProjectEvent implements ProjectEvent {
  _CreateProjectEvent({
    required this.name,
    required this.description,
    required this.organization,
  });

  final String name;
  final String description;
  final String organization;
}
