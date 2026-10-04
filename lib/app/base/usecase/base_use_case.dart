abstract class BaseUseCase<Input, Output> {
  Future<Output> excecute(Input input);
}
