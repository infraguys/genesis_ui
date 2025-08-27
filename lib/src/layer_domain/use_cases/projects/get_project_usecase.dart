import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/get_project_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class GetProjectUseCase {
  const GetProjectUseCase(this._projectsRepository);

  final IProjectsRepository _projectsRepository;

  Future<Project> call(GetProjectParams params) async {
    return await _projectsRepository.getProject(params);
  }
}
