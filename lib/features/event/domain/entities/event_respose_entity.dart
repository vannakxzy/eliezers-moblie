import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/event/event_model.dart';

import '../../../../data/models/meta_model.dart';

part 'event_respose_entity.freezed.dart';

@freezed
class EventResposeEntity with _$EventResposeEntity {
  factory EventResposeEntity({
    @Default([]) List<EventModel> data,
    MetaModel? mate,
  }) = _EventResposeEntity;
}
