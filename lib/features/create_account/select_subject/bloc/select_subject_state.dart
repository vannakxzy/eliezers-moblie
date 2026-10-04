part of 'select_subject_bloc.dart';

@freezed
class SelectSubjectState extends BaseState with _$SelectSubjectState {
  const factory SelectSubjectState({
    @Default(0) int step,
    @Default([]) List<int> selectedSucject,
    @Default(0) int numberSelect,
    @Default([]) List<SubjectEntity> subject,
    @Default(false) bool isloading,
    @Default(false) bool loadingUpdateSubject,
  }) = _Initial;
}
