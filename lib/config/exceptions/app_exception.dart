class AppException implements Exception {
  AppException(this.exceptionType, this.error);

  Object error;

  final AppExceptionType exceptionType;
}

enum AppExceptionType {
  service,
  remote,
  parse,
  remoteConfig,
  uncaught,
  validation,
  system,
}
