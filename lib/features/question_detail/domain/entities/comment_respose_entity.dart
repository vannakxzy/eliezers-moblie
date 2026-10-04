import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/meta_model.dart';
import '../../../../data/models/question_detail/comment_model.dart';
part 'comment_respose_entity.freezed.dart';

@freezed
class CommentResposeEntity with _$CommentResposeEntity {
  factory CommentResposeEntity({
    @Default([]) List<CommentModel> data,
    MetaModel? meta,
  }) = _CommentResposeEntity;
}
