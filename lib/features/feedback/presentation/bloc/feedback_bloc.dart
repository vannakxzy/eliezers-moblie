import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecase/submit_feedback_usecase.dart';
import '../../../../app/base/bloc/bloc.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';
part 'feedback_bloc.freezed.dart';

@Injectable()
class FeedbackBloc extends BaseBloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc(this._submitFeedbackUseCase) : super(const _Initial()) {
    on<DescriptionChangedEvent>(_onDescriptionChanged);
    on<ClickSubmitEvent>(_submitFeedback);
  }
  final SubmitFeedbackUseCase _submitFeedbackUseCase;

  FutureOr<void> _onDescriptionChanged(
      DescriptionChangedEvent event, Emitter<FeedbackState> emit) async {
    emit(state.copyWith(description: event.value));
  }

  final descriptionTextController = TextEditingController();

  FutureOr<void> _submitFeedback(
      ClickSubmitEvent event, Emitter<FeedbackState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));

        await _submitFeedbackUseCase.excecute(
          state.description,
        );

        emit(state.copyWith(
          isLoading: false,
          description: '',
        ));

        appRoute.pop();
        appRoute.showSuccessSnackBar('Feedback has been submit successfully!');
      },
      onError: (error) async {
        emit(
          state.copyWith(
            isLoading: false,
          ),
        );
      },
    );
  }
}
