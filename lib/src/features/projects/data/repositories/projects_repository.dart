import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';
import 'package:genesis/src/features/projects/domain/params/update_project_paramas.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';

final class ProjectsRepository implements IProjectsRepository {
  @override
  Future<Project> createProject(CreateProjectParams params) {
    // TODO: implement createProject
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProject(String uuid) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }

  @override
  Future<Project> updateProject(UpdateProjectParams params) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }

  Future<List<Project>> getProjects() {
    // TODO: implement updateProject
    throw UnimplementedError();
  }
}
