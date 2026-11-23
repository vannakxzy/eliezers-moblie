import 'package:json_annotation/json_annotation.dart';

import '../../../features/bible/domain/entities/bible_book_intro_entity.dart';
import '../../../features/bible/domain/entities/bible_content_entity.dart';
import 'bible_book_chapter_model.dart';
import 'bible_book_intro_model.dart';

part 'bible_content_model.g.dart';

@JsonSerializable()
class BibleContentModel {
  BibleContentModel({
    this.id,
    this.title,
    this.full_title,
    this.abbreviation,
    this.canon,
    this.chapters,
    this.intro,
  });

  String? id;
  String? title;
  String? full_title;
  String? abbreviation;
  String? canon;
  List<BibleBookChapterModel>? chapters;
  BibleBookIntroModel? intro;

  factory BibleContentModel.fromJson(Map<String, dynamic> json) =>
      _$BibleContentModelFromJson(json);
}

extension BibleContentModelToEntity on BibleContentModel {
  BibleContentEntity toEntity() => BibleContentEntity(
        id: id ?? '',
        title: title ?? '',
        full_title: full_title ?? '',
        abbreviation: abbreviation ?? '',
        canon: canon ?? '',
        chapters: chapters?.toListEntity() ?? [],
        intro: intro?.toEntity() ?? const BibleBookIntroEntity(),
      );
}

extension BibleContentModelListToEntity on List<BibleContentModel> {
  List<BibleContentEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
