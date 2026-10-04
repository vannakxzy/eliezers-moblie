abstract class BaseInputUseCase<Input> {
  Future<void> execute(Input input);
}
