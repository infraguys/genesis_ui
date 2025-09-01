import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class GetProjectUseCase {
  const GetProjectUseCase(this._projectsRepository);

  final IProjectsRepository _projectsRepository;

  Future<Project> call(ProjectUUID uuid) async {
    return await _projectsRepository.getProject(uuid);
  }
}
