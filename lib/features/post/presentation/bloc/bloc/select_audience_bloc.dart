import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/helper/local_data/storge_local.dart';

import '../../../../../app/base/bloc/bloc.dart';

part 'select_audience_event.dart';
part 'select_audience_state.dart';
part 'select_audience_bloc.freezed.dart';

@Injectable()
class SelectAudienceBloc
    extends BaseBloc<SelectAudienceEvent, SelectAudienceState> {
  SelectAudienceBloc() : super(_Initial()) {
    on<ClickAudienceEvent>(_clickAudience);
    on<ClickSetDefualt>(_clickSetDefault);
    on<InitPage>(_initPage);
    on<ClickDone>(_clickDone);
  }
  FutureOr<void> _clickAudience(
      ClickAudienceEvent event, Emitter<SelectAudienceState> emit) async {
    emit(state.copyWith(audience: event.value));
    if (event.value != state.oldAudience) {
      emit(state.copyWith(isSetDefault: false));
    } else {
      emit(state.copyWith(isSetDefault: true));
    }
  }

  FutureOr<void> _initPage(
      InitPage event, Emitter<SelectAudienceState> emit) async {
    String oldAudience =
        LocalStorage.getStringValue(SharedPreferenceKeys.audience);
    emit(state.copyWith(audience: event.value, oldAudience: oldAudience));
    if (event.value != state.oldAudience) {
      emit(state.copyWith(isSetDefault: false));
    } else {
      emit(state.copyWith(isSetDefault: true));
    }
  }

  FutureOr<void> _clickSetDefault(
      ClickSetDefualt event, Emitter<SelectAudienceState> emit) async {
    emit(state.copyWith(isSetDefault: !state.isSetDefault));
  }

  FutureOr<void> _clickDone(
      ClickDone event, Emitter<SelectAudienceState> emit) async {
    if (state.isSetDefault) {
      LocalStorage.storeData(
          key: SharedPreferenceKeys.audience, value: state.audience);
    }
  }
}
