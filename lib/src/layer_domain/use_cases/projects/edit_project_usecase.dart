import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/edit_project_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class EditProjectUseCase {
  EditProjectUseCase(this._repository);

  final IProjectsRepository _repository;

  Future<Project> call(EditProjectParams params) async {
    return await _repository.editProject(params);
  }
}
