import 'package:genesis/src/layer_domain/params/projects/delete_project_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class DeleteProjectUseCase {
  DeleteProjectUseCase(this._repository);

  final IProjectsRepository _repository;

  Future<void> call(DeleteProjectParams params) async {
    await _repository.deleteProject(params);
  }
}
