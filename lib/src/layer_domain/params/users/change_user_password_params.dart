class ChangeUserPasswordParams {
  ChangeUserPasswordParams({
    required this.uuid,
    required this.oldPassword,
    required this.newPassword,
  });

  final String uuid;
  final String oldPassword;
  final String newPassword;
}
