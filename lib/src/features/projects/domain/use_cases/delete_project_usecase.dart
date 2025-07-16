import 'package:genesis/src/features/projects/data/repositories/projects_repository.dart';

final class DeleteProjectUseCase {
  DeleteProjectUseCase(this._repository);

  final ProjectsRepository _repository;

  Future<void> call(String projectUuid) async {
    await _repository.deleteProject(projectUuid);
  }
}
