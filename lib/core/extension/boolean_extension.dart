extension IsTrueOrNull on bool {
  T? maybe<T>(T? value) => this == true ? value : null;

  T trueOrFalse<T>(T t, T f) => this == true ? t : f;
}
