abstract interface class IUseCase<Params, Result> {
  Future<Result> call(Params params);
}
