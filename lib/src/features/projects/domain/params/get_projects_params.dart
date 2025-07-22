final class GetProjectsParams {
  const GetProjectsParams({
    required this.userUuid,
    this.projectName,
  });

  final String userUuid;
  final String? projectName;
}
