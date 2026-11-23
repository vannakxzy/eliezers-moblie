import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features/bible/domain/entities/bible_book_entity.dart';

part 'bible_book_model.g.dart';

@JsonSerializable()
class BibleBookModel {
  BibleBookModel(
      {this.id,
      this.abbreviation,
      this.books,
      this.copyright,
      this.language_tag,
      this.localized_abbreviation,
      this.localized_title,
      this.organization_id,
      this.promotional_content,
      this.publisher_name,
      this.publisher_url,
      this.title,
      this.youversion_deep_link});
  int? id;
  String? abbreviation;
  String? promotional_content;
  String? copyright;
  String? publisher_name;
  String? publisher_url;
  String? language_tag;
  String? localized_abbreviation;
  String? localized_title;
  String? title;
  List<String>? books;
  String? youversion_deep_link;
  String? organization_id;
  factory BibleBookModel.fromJson(Map<String, dynamic> json) =>
      _$BibleBookModelFromJson(json);
}

extension BibleBookModelToEnity on BibleBookModel {
  BibleBookEntity toEntity() => BibleBookEntity(
      abbreviation: abbreviation ?? "",
      books: books ?? [],
      copyright: copyright ?? "",
      id: id ?? 0,
      language_tag: language_tag ?? "",
      localized_abbreviation: localized_abbreviation ?? "",
      localized_title: localized_title ?? "",
      organization_id: organization_id ?? "",
      promotional_content: promotional_content ?? "",
      publisher_name: publisher_name ?? "",
      publisher_url: publisher_url ?? "",
      title: title ?? "",
      youversion_deep_link: youversion_deep_link ?? "");
}

extension QuestionModelToListEntity on List<BibleBookModel> {
  List<BibleBookEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
