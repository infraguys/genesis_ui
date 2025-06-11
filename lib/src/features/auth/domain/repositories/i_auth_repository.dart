abstract interface class IAuthRepository {
  Future<void> createTokenByPassword({
    required String iamClientUuid,
});
}