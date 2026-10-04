import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/base/bloc/base_bloc.dart';
import '../../../../../app/base/bloc/base_event.dart';
import '../../../../../app/base/bloc/base_state.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../../config/theme/theme_controller.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/helper/local_data/storge_local.dart';
import '../../../../../di/di.dart';
import '../../../../../gen/i18n/translations.g.dart';

part 'appearance_event.dart';
part 'appearance_state.dart';
part 'appearance_bloc.freezed.dart';

@Injectable()
class AppearanceBloc extends BaseBloc<AppearanceEvent, AppearanceState> {
  AppearanceBloc() : super(const _Initial()) {
    on<ClickThemeEvent>(_clickTheme);
    on<InitPage>(_initPage);
  }
  FutureOr<void> _clickTheme(
      ClickThemeEvent event, Emitter<AppearanceState> emit) {
    getIt.get<ThemeController>().toggleThemeChange();
    String theme = LocalStorage.getStringValue(SharedPreferenceKeys.theme);
    if (theme == "dark") {
      theme = t.setting.dark;
      emit(state.copyWith(icon: MoonIcons.other_moon_24_light));
    } else {
      theme = t.setting.light;
      emit(state.copyWith(icon: MoonIcons.other_sun_24_light));
    }
    emit(state.copyWith(theme: theme));
  }

  FutureOr<void> _initPage(InitPage event, Emitter<AppearanceState> emit) {
    String theme = LocalStorage.getStringValue(SharedPreferenceKeys.theme);
    if (theme == "dark") {
      theme = t.setting.dark;
      emit(state.copyWith(icon: MoonIcons.other_moon_24_light));
    } else {
      theme = t.setting.light;
      emit(state.copyWith(icon: MoonIcons.other_sun_24_light));
    }
    emit(state.copyWith(theme: theme));
  }
}
