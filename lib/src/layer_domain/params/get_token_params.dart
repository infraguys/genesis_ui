base class GetTokenParams {
  GetTokenParams({
    required this.username,
    required this.password,
    this.scope = '',
  });

  final String? username;
  final String? password;
  final String? scope;

  GetTokenParams copyWith({
    String? username,
    String? password,
    String? scope,
  }) {
    return GetTokenParams(
      username: username ?? this.username,
      password: password ?? this.password,
      scope: scope ?? this.scope,
    );
  }
}
