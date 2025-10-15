import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';

final class CreateProjectUseCase {
  CreateProjectUseCase(this._projectsRepository);

  final IProjectsRepository _projectsRepository;

  Future<Project> call(CreateProjectParams params) async {
    return await _projectsRepository.createProject(params);
  }
}
