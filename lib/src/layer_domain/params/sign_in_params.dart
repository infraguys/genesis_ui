class SignInParams {
  SignInParams({
    required this.username,
    required this.password,
    this.scope = '',
  });

  final String username;
  final String password;
  final String scope;

  SignInParams copyWith({
    String? username,
    String? password,
    String? scope,
  }) {
    return SignInParams(
      username: username ?? this.username,
      password: password ?? this.password,
      scope: scope ?? this.scope,
    );
  }
}
