import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';

final class CreateProjectUseCase {
  CreateProjectUseCase(this._repository);

  final IProjectsRepository _repository;

  Future<Project> call(CreateProjectParams params) async {
    return await _repository.createProject(params);
  }
}
