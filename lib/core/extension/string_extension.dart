extension StringExtension on String? {
  bool get isNull => this == null;

  bool get isEmptyOrNull => isNull || this?.isEmpty == true;

  bool get isNotEmptyOrNull => this?.isNotEmpty ?? false;
  String toStringNotNull() => this ?? '';

  String firstUpper() =>
      isNotEmptyOrNull ? this![0].toUpperCase() + this!.substring(1) : '';
}
