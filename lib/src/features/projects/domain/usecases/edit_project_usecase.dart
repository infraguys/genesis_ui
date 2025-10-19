import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/edit_project_params.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';

final class EditProjectUseCase {
  EditProjectUseCase(this._repository);

  final IProjectsRepository _repository;

  Future<Project> call(UpdateProjectParams params) async {
    return await _repository.editProject(params);
  }
}
