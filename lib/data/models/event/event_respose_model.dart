import 'package:json_annotation/json_annotation.dart';
import '../../../features/event/domain/entities/event_respose_entity.dart';
import '../meta_model.dart';
import 'event_model.dart';

part 'event_respose_model.g.dart';

@JsonSerializable(includeIfNull: true)
class EventResposeModel {
  EventResposeModel({
    this.data,
    this.meta,
  });

  final List<EventModel>? data;
  final MetaModel? meta;

  factory EventResposeModel.fromJson(Map<String, dynamic> json) =>
      _$EventResposeModelFromJson(json);
}

extension EventResposeModelToEntity on EventResposeModel {
  EventResposeEntity toEntity() =>
      EventResposeEntity(data: data ?? [], mate: meta);
}

extension EventResposeModelToListEntity on List<EventResposeModel> {
  List<EventResposeEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
