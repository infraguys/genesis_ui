import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/create_project_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class CreateProjectUseCase {
  CreateProjectUseCase(this._projectsRepository);

  final IProjectsRepository _projectsRepository;

  Future<Project> call(CreateProjectParams params) async {
    return await _projectsRepository.createProject(params);
  }
}
