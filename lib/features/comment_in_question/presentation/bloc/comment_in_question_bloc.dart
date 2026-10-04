import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/models/question_detail/comment_model.dart';
import '../../domain/usecase/delete_comment_usecase.dart';
import '../../domain/usecase/like_comment_usecase.dart';
import '../../domain/usecase/un_like_comment_usecase.dart';
import '../../domain/usecase/update_comment_usecase.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../data/data_sources/remotes/comment_in_question_api_service.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../question_detail/domain/entities/comment_entity.dart';
import '../../domain/usecase/create_comment_usecase.dart';
import '../../domain/usecase/get_comment_in_quesiton_usecase.dart';
part 'comment_in_question_event.dart';
part 'comment_in_question_state.dart';
part 'comment_in_question_bloc.freezed.dart';

@Injectable()
class CommentInQuestionBloc
    extends BaseBloc<CommentInQuestionEvent, CommentInQuestionState> {
  CommentInQuestionBloc(
    this._getCommnetInQuestionUserCase,
    this._createCommentUseCase,
    this._deleteCommentUsecase,
    this._likeCommentUsecase,
    this._unLikeCommentUsecase,
    this._updateCommentUsecase,
  ) : super(const _Initial()) {
    on<GetCommentEvent>(_getCommnetInQuestion);
    on<ClickCancelEditEvent>(_cancelEdit);
    on<ClickCreateEventcommentEvent>(_createComment);
    on<ClickDeleteEvent>(_clickDeleteComment);
    on<ClickEditEvent>(_edit);
    on<DesChangedEvent>(_onDescriptionChanged);
    on<ClickUpdateEvent>(_update);
    on<RefreshPage>(_refreshPage);
    on<ClickLike>(_clickLike);
  }

  final GetCommnetInQuestionUserCase _getCommnetInQuestionUserCase;
  final CreateCommentUseCase _createCommentUseCase;
  final DeleteCommentUsecase _deleteCommentUsecase;
  final UpdateCommentUsecase _updateCommentUsecase;
  final LikeCommentUseCase _likeCommentUsecase;
  final UnLikeCommentUsecase _unLikeCommentUsecase;

  FutureOr<void> _edit(
      ClickEditEvent event, Emitter<CommentInQuestionState> emit) async {
    final oldDes = state.comments[event.index].message;
    final mes = state.message;
    emit(state.copyWith(
      desTextController: TextEditingController(text: oldDes),
      oldMessage: oldDes,
      updateIndex: event.index,
      beforeeditMessage: mes,
      message: "",
    ));
    _enableComment(emit);
  }

  FutureOr<void> _clickLike(
      ClickLike event, Emitter<CommentInQuestionState> emit) async {
    List<CommentEntity> comments = [...state.comments];
    await runAppCatching(
      () async {
        final correntAnswer = comments[event.index];
        final correntLike = correntAnswer.count_like;
        if (correntAnswer.is_like == true) {
          comments[event.index] = correntAnswer.copyWith(
              count_like: correntLike - 1, is_like: false);
          emit(state.copyWith(comments: comments));

          await _unLikeCommentUsecase.excecute(correntAnswer.id);
        } else {
          comments[event.index] = correntAnswer.copyWith(
              count_like: correntLike + 1, is_like: true);
          emit(state.copyWith(comments: comments));
          await _likeCommentUsecase.excecute(correntAnswer.id);
        }
      },
    );
  }

  FutureOr<void> _update(
      ClickUpdateEvent event, Emitter<CommentInQuestionState> emit) async {
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
      ClickCancelEditEvent event, Emitter<CommentInQuestionState> emit) {
    emit(state.copyWith(
      oldMessage: "",
      desTextController: TextEditingController(text: state.beforeeditMessage),
      message: state.beforeeditMessage,
    ));
    _enableComment(emit);
  }

  FutureOr<void> _clickDeleteComment(
      ClickDeleteEvent event, Emitter<CommentInQuestionState> emit) async {
    runAppCatching(
      () async {
        int id = state.comments[event.index].id;
        final comment = [...state.comments];
        comment.removeAt(event.index);
        emit(state.copyWith(comments: comment));
        emit(state.copyWith(valueUpdated: state.valueUpdated - 1));

        await _deleteCommentUsecase.excecute(id);
      },
    );
  }

  FutureOr<void> _createComment(ClickCreateEventcommentEvent event,
      Emitter<CommentInQuestionState> emit) async {
    await runAppCatching(
      () async {
        List<CommentEntity> comment = [...state.comments];
        String des = state.message;
        comment.add(
          CommentEntity(
              date: t.common.justNow,
              message: des,
              name: LocalStorage.getStringValue(SharedPreferenceKeys.name),
              avatar: LocalStorage.getStringValue(SharedPreferenceKeys.avatar),
              isEditDone: true,
              isPostDone: false),
        );
        emit(state.copyWith(
          comments: comment,
          message: '',
          desTextController: TextEditingController(text: ''),
        ));
        _enableComment(emit);
        final commentNew = await _createCommentUseCase.excecute(CommentInput(
            message: des,
            question_id: event.questionId,
            band_id: event.bandId));
        List<CommentEntity> com = [...state.comments];
        final yourComment = com.last;
        com.last = yourComment.copyWith(isPostDone: true, id: commentNew.id);
        emit(state.copyWith(comments: com));
        emit(state.copyWith(valueUpdated: state.valueUpdated + 1));
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _getCommnetInQuestion(
      GetCommentEvent event, Emitter<CommentInQuestionState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(getLoadingComment: true));
        final commentRespose = await _getCommnetInQuestionUserCase.excecute(
            GetCommentInQuestionInput(
                page: state.page, question_id: event.questionId));
        final all = [...state.comments];
        all.addAll(commentRespose.data.toListEntity());
        emit(state.copyWith(
            getLoadingComment: false, comments: all, page: state.page + 1));
        if (state.page > commentRespose.meta!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(getLoadingComment: false));
      },
    );
  }

  FutureOr<void> _refreshPage(
      RefreshPage event, Emitter<CommentInQuestionState> emit) async {
    await runAppCatching(
      () async {
        emit(
            state.copyWith(getLoadingComment: true, page: 1, isMorePage: true));
        final commentRespose = await _getCommnetInQuestionUserCase.excecute(
            GetCommentInQuestionInput(
                page: state.page, question_id: event.questionId));
        emit(state.copyWith(
            getLoadingComment: false,
            comments: commentRespose.data.toListEntity(),
            page: state.page + 1));
        if (state.page > commentRespose.meta!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(getLoadingComment: false));
      },
    );
  }

  FutureOr<void> _onDescriptionChanged(
      DesChangedEvent event, Emitter<CommentInQuestionState> emit) async {
    emit(state.copyWith(message: event.value));
    _enableComment(emit);
  }

  void _enableComment(Emitter<CommentInQuestionState> emit) {
    if ((state.message.isNotEmpty) && state.oldMessage != state.message) {
      emit(state.copyWith(enableComment: true));
    } else {
      emit(state.copyWith(enableComment: false));
    }
  }
}
