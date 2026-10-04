class ValidationException implements Exception {
  ValidationException({
    required this.title,
    required this.message,
  }) : super();

  final String title;
  final String message;

  @override
  String toString() => '[ValidationException]: $title -> $message';
}
