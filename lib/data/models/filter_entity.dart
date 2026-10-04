// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../features/post/domain/entities/tag_entity.dart';

part 'filter_entity.freezed.dart';

@freezed
class FilterEntity with _$FilterEntity {
  const factory FilterEntity(
      {@Default([]) List<TagEntity> tag,
      @Default('') String status,
      @Default('') String date,
      @Default('') String like,
      @Default('') String type,
      @Default(0) int band_id}) = _FilterEntity;

  // factory FilterEntity.fromJson(Map<String, dynamic> json) =>
  //     _$FilterEntityFromJson(json);
}

extension FilterEntityExtension on FilterEntity {
  int get activeFilterCount {
    int count = 0;
    if (status.isNotEmpty) count++;
    if (date.isNotEmpty) count++;
    if (like.isNotEmpty) count++;
    if (type.isNotEmpty) count++;
    if (tag.isNotEmpty) count++;
    return count;
  }
}
