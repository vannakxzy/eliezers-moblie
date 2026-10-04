import 'package:freezed_annotation/freezed_annotation.dart';
part 'block_entity.freezed.dart';

@freezed
class BlockEntity with _$BlockEntity {
  factory BlockEntity({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String user_name,
    @Default('') String profile,
    @Default('') String date,
  }) = _BlockEntity;
}
