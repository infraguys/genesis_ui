import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';

final class GetProjectUseCase {
  const GetProjectUseCase(this._projectsRepository);

  final IProjectsRepository _projectsRepository;

  Future<Project> call(ProjectID uuid) async {
    return await _projectsRepository.getProject(uuid);
  }
}
