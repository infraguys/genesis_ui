import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';
import 'package:genesis/src/features/projects/domain/params/edit_project_params.dart';
import 'package:genesis/src/features/projects/domain/params/get_projects_params.dart';

abstract interface class IProjectsRepository {
  Future<Project> createProject(CreateProjectParams params);

  Future<void> deleteProject(ProjectID uuid);

  Future<Project> editProject(EditProjectParams params);

  Future<Project> getProject(ProjectID uuid);

  Future<List<Project>> getProjects(GetProjectsParams params);
}
