extension StringUtils on String? {
  bool get istNotNull => this != null;
  // bool get isNotEmptyOrNull => !istNotNull && (this?.isNotEmpty ?? true);
  // bool get isEmptyOrNull => istNotNull && this!.isEmpty;
}
