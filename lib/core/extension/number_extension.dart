extension NumberExtension on num? {
  String toStringNotNull() => this?.toString() ?? '0';
}
