// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../data/models/filter_entity.dart';
import '../../../category/domain/entities/category_entity.dart';
import '../../domain/entities/question_entity.dart';

import '../../../../app/base/bloc/bloc.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ClickNotification>(_clickNotification);
  }

  FutureOr<void> _clickNotification(HomeEvent event, Emitter<HomeState> emit) {
    debugPrint("nanananananananan ");
    appRoute.push(AppRouteInfo.notification());
  }
}
