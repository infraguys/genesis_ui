import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/update_project_paramas.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class UpdateProjectUseCase {
  UpdateProjectUseCase(this._repository);

  final IProjectsRepository _repository;

  Future<Project> call(UpdateProjectParams params) async {
    return await _repository.updateProject(params);
  }
}
