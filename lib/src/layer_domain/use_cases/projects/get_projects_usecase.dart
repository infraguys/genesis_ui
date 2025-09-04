import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/get_projects_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class GetProjectsUseCase {
  const GetProjectsUseCase(this._projectsRepository);

  final IProjectsRepository _projectsRepository;

  Future<List<Project>> call(GetProjectsParams params) async {
    return await _projectsRepository.getProjects(params);
  }
}
