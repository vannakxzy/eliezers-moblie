import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/models/question_detail/comment_model.dart';
import '../../../comment_in_question/domain/usecase/delete_comment_usecase.dart';
import '../../../comment_in_question/domain/usecase/like_comment_usecase.dart';
import '../../../comment_in_question/domain/usecase/un_like_comment_usecase.dart';
import '../../../comment_in_question/domain/usecase/update_comment_usecase.dart';
import '../../../question_detail/domain/entities/comment_entity.dart';
import '../../domain/usecase/create_comment_in_answer_usecase.dart';
import '../../domain/usecase/get_comment_in_answer_usecase.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../data/data_sources/remotes/comment_in_answer_api_service.dart';
import '../../../../data/data_sources/remotes/comment_in_question_api_service.dart';
import '../../../../gen/i18n/translations.g.dart';

part 'comment_in_answer_event.dart';
part 'comment_in_answer_state.dart';
part 'comment_in_answer_bloc.freezed.dart';

@Injectable()
class CommentInAnswerBloc
    extends BaseBloc<CommentInAnswerEvent, CommentInAnswerState> {
  CommentInAnswerBloc(
      this._getCommentInAnswer,
      this._createCommentInAnswerUsecase,
      this._deleteCommentUsecase,
      this._updateCommentUsecase,
      this._likeCommentUsecase,
      this._unLikeCommentUsecase)
      : super(const CommentInAnswerState()) {
    on<GetCommentEvent>(_getcommentInAnswer);
    on<ClickEditEvent>(_clickEdit);
    on<ClickUpdateEvent>(_update);
    on<ClickCancelEditEvent>(_cancelEdit);
    on<ClickDeleteEvent>(_clickDeleteComment);
    on<DesChangedEvent>(_desChange);
    on<ClickCreateEventCommentEvent>(_createComment);
    on<RefresPage>(_refresPage);
    on<ClickLike>(_clickLike);
  }

  final GetCommentInAnswerUseCase _getCommentInAnswer;
  final CreateCommentInAnswerUsecase _createCommentInAnswerUsecase;
  final DeleteCommentUsecase _deleteCommentUsecase;
  final UpdateCommentUsecase _updateCommentUsecase;
  final LikeCommentUseCase _likeCommentUsecase;
  final UnLikeCommentUsecase _unLikeCommentUsecase;

  FutureOr<void> _clickLike(
      ClickLike event, Emitter<CommentInAnswerState> emit) async {
    final comments = [...state.comments];
    CommentEntity currentComment = comments[event.index];
    await runAppCatching(
      () async {
        if (currentComment.is_like) {
          comments[event.index] = currentComment.copyWith(
              is_like: false, count_like: currentComment.count_like - 1);
          emit(state.copyWith(comments: comments));
          await _unLikeCommentUsecase.excecute(currentComment.id);
        } else {
          comments[event.index] = currentComment.copyWith(
              is_like: true, count_like: currentComment.count_like + 1);
          emit(state.copyWith(comments: comments));
          await _likeCommentUsecase.excecute(currentComment.id);
        }
      },
    );
  }

  FutureOr<void> _clickEdit(
      ClickEditEvent event, Emitter<CommentInAnswerState> emit) async {
    final oldDes = state.comments[event.index].message;
    final mess = state.message;
    emit(state.copyWith(
        desTextController: TextEditingController(text: oldDes),
        oldMessage: oldDes,
        updateIndex: event.index,
        beforeeditMessage: mess,
        message: ""));
    _enableComment(emit);
  }

  FutureOr<void> _update(
      ClickUpdateEvent event, Emitter<CommentInAnswerState> emit) async {
    await runAppCatching(
      () async {
        List<CommentEntity> comment = [...state.comments];
        final currentComment = comment[state.updateIndex];
        final message = state.message;
        comment[state.updateIndex] =
            currentComment.copyWith(message: state.message, isEditDone: false);
        emit(state.copyWith(comments: comment));
        emit(state.copyWith(
            oldMessage: "",
            desTextController: TextEditingController(text: ""),
            message: ""));
        _enableComment(emit);
        await _updateCommentUsecase.excecute(CommentInput(
            message: message, question_id: currentComment.id, band_id: 0));
        List<CommentEntity> UpDatecomment = [...state.comments];
        final currentUpdate = UpDatecomment[state.updateIndex];
        UpDatecomment[state.updateIndex] =
            currentUpdate.copyWith(isEditDone: true);
        emit(state.copyWith(comments: UpDatecomment));
      },
      onError: (error) async {
        List<CommentEntity> UpDatecomment = [...state.comments];
        final currentUpdate = UpDatecomment[state.updateIndex];
        UpDatecomment[state.updateIndex] =
            currentUpdate.copyWith(isEditDone: true);
        emit(state.copyWith(comments: UpDatecomment));
      },
    );
  }

  FutureOr<void> _cancelEdit(
      ClickCancelEditEvent event, Emitter<CommentInAnswerState> emit) {
    emit(state.copyWith(
        oldMessage: "",
        desTextController: TextEditingController(text: state.beforeeditMessage),
        message: state.beforeeditMessage));
    _enableComment(emit);
  }

  FutureOr<void> _clickDeleteComment(
      ClickDeleteEvent event, Emitter<CommentInAnswerState> emit) async {
    await runAppCatching(
      () async {
        int id = state.comments[event.index].id;
        final comment = [...state.comments];
        comment.removeAt(event.index);
        emit(state.copyWith(comments: comment));
        await _deleteCommentUsecase.excecute(id);
      },
    );
  }

  FutureOr<void> _getcommentInAnswer(
      GetCommentEvent event, Emitter<CommentInAnswerState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true));
        final commentResopose = await _getCommentInAnswer.excecute(
            GetCommentAnswerInput(page: state.page, answer_id: event.answerId));
        final all = [...state.comments];
        all.addAll(commentResopose.data.toListEntity());
        emit(state.copyWith(
            comments: all, isloading: false, page: state.page + 1));
        if (state.page > commentResopose.meta!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
        debugPrint("eroror $error");
      },
    );
  }

  FutureOr<void> _refresPage(
      RefresPage event, Emitter<CommentInAnswerState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true, isMorePage: true, page: 1));
        final commentResopose = await _getCommentInAnswer.excecute(
            GetCommentAnswerInput(page: state.page, answer_id: event.answerId));
        emit(state.copyWith(
            comments: commentResopose.data.toListEntity(),
            isloading: false,
            page: state.page + 1));
        if (state.page > commentResopose.meta!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _desChange(
      DesChangedEvent event, Emitter<CommentInAnswerState> emit) async {
    emit(state.copyWith(message: event.text));
    _enableComment(emit);
  }

  FutureOr<void> _createComment(ClickCreateEventCommentEvent event,
      Emitter<CommentInAnswerState> emit) async {
    try {
      List<CommentEntity> comment = [...state.comments];
      final des = state.message;
      comment.add(
        CommentEntity(
          date: t.common.justNow,
          id: 0,
          message: state.message,
          name: LocalStorage.getStringValue(SharedPreferenceKeys.name),
          count_like: 0,
          isPostDone: false,
          user_id: 1,
          avatar: LocalStorage.getStringValue(SharedPreferenceKeys.avatar),
        ),
      );
      emit(state.copyWith(
        comments: comment,
        message: '',
        desTextController: TextEditingController(text: ''),
      ));
      _enableComment(emit);
      final newomment = await _createCommentInAnswerUsecase.excecute(
          CreateCommnetInAnswer(
              answer_id: event.answerId, message: des, band_id: event.bandId));
      final comm = [...state.comments];
      final yourComment = comm.last;
      comm.last = yourComment.copyWith(isPostDone: true, id: newomment.id);
      emit(state.copyWith(comments: comm));
    } catch (e) {
      debugPrint("catch $e");
    }
  }

  void _enableComment(Emitter<CommentInAnswerState> emit) {
    if ((state.message.isNotEmpty)) {
      emit(state.copyWith(enableComment: true));
    } else {
      emit(state.copyWith(enableComment: false));
    }
  }
}
