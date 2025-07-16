import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';
import 'package:genesis/src/features/projects/domain/params/get_projects_params.dart';
import 'package:genesis/src/features/projects/domain/params/update_project_paramas.dart';

abstract interface class IProjectsRepository {
  Future<Project> createProject(CreateProjectParams params);

  Future<void> deleteProject(String projectUuid);

  Future<Project> updateProject(UpdateProjectParams params);

  Future<List<Project>> getProjects(GetProjectsParams params);
}
