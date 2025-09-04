import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/projects/get_projects_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class GetProjectsByUserUseCase {
  const GetProjectsByUserUseCase(this._projectsRepository);

  final IProjectsRepository _projectsRepository;

  Future<List<({Project project, List<Role> roles})>> call(GetProjectsParams params) async {
    return await _projectsRepository.getProjectsByUser(params);
  }
}
