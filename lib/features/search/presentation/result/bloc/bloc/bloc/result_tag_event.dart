part of 'result_tag_bloc.dart';

class ResultTagEvent extends BaseEvent {}

@freezed
class GetTags extends ResultTagEvent with _$GetTags {
  factory GetTags(String q) = _GetTags;
}

@freezed
class ClickTag extends ResultTagEvent with _$ClickTag {
  factory ClickTag(TagEntity tag) = _ClickTag;
}

@freezed
class RefreshPageP extends ResultTagEvent with _$RefreshPageP {
  factory RefreshPageP(String q) = _RefreshPageP;
}

@freezed
class RemoveIndex extends ResultTagEvent with _$RemoveIndex {
  factory RemoveIndex(int index) = _RemoveIndex;
}

@freezed
class RemoveAll extends ResultTagEvent with _$RemoveAll {
  factory RemoveAll() = _RemoveAll;
}
