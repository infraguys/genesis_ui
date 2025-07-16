import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';

final class DeleteProjectUseCase {
  DeleteProjectUseCase(this._repository);

  final IProjectsRepository _repository;

  Future<void> call(String projectUuid) async {
    await _repository.deleteProject(projectUuid);
  }
}
