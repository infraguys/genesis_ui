import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class DeleteProjectUseCase {
  DeleteProjectUseCase(this._repository);

  final IProjectsRepository _repository;

  Future<void> call(ProjectUUID uuid) async {
    await _repository.deleteProject(uuid);
  }
}
