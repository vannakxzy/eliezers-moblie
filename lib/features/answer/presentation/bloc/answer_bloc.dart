import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../data/data_sources/remotes/comment_in_answer_api_service.dart';
import '../../../../data/data_sources/remotes/comment_in_question_api_service.dart';
import '../../../../data/models/profile/answer_model.dart';
import '../../../../data/models/question_detail/comment_model.dart';
import '../../../comment_in_answer/domain/usecase/create_comment_in_answer_usecase.dart';
import '../../../comment_in_answer/domain/usecase/get_comment_in_answer_usecase.dart';
import '../../../comment_in_question/domain/usecase/delete_comment_usecase.dart';
import '../../../comment_in_question/domain/usecase/like_comment_usecase.dart';
import '../../../comment_in_question/domain/usecase/un_like_comment_usecase.dart';
import '../../../comment_in_question/domain/usecase/update_comment_usecase.dart';
import '../../../question_detail/domain/entities/comment_entity.dart';
import '../../domain/usecase/delete_answer_usecase.dart';
import '../../../question_detail/domain/usecase/correct_answer_usecase.dart';
import '../../../question_detail/domain/usecase/like_answer_usecase.dart';
import '../../../question_detail/domain/usecase/un_like_answer_usecase.dart';

import '../../../../data/data_sources/remotes/answer_api_service.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../profile/domain/entities/answer_entity.dart';
import '../../../question_detail/alert/confirm_delete_answer_alert.dart';
import '../../alert/confirm_correct_answer_alert.dart';
import '../../domain/usecase/create_answer_usercase.dart';
import '../../domain/usecase/get_answer_in_question_usecase.dart';
import '../../domain/usecase/update_answer_usecase.dart';

part 'answer_bloc.freezed.dart';
part 'answer_event.dart';
part 'answer_state.dart';

@Injectable()
class AnswerBloc extends BaseBloc<AnswerEvent, AnswerState> {
  AnswerBloc(
      this._createAnswerUseCase,
      this._getAnswerUseCase,
      this._likeAnswerUseCase,
      this._createCommentInAnswerUsecase,
      this._correctAnswerUsecase,
      this._deleteAnswerUsecase,
      this._unLikeAnswerUsecase,
      this._unLikeCommentUsecase,
      this._likeCommentUsecase,
      this._updateCommentUsecase,
      this._getCommentInAnswerUsecase,
      this._deleteCommentUsecase,
      this._updateAnswerUsecase)
      : super(const AnswerState()) {
    on<GetAnswerEvent>(_getAnswer);
    on<ClickCancelEditEvent>(_cancelEdit);
    on<ClickCorrentEvent>(_clickCorrectAnswer);
    on<ClickDeleteEvent>(_clickDeleteAnswer);
    on<ClickLikeEvent>(_clickLike);
    on<ClickEditEvent>(_clickEdit);
    on<ClickUpdateEvent>(_clickUpdate);
    on<ClickProfileEvent>(_clickProfile);
    on<ClickPickImageEvent>(_pickImage);
    on<ScrollDirectionUpdate>(_scrollDirectionUpdateEvent);
    on<ClickClearImageEvent>(_clearImage);
    on<DescriptionChangedEvent>(_onmessageChanged);
    on<ClcikCreateAnswerEvent>(_createAnswer);
    on<ClickDownloadImage>(_clickDownload);
    on<RefreshPage>(_refreshpage);
    on<ClickGetComment>(_clickGetComment);
    on<ClickLlikeComment>(_clickLikeComment);
    on<ClickDeleteComment>(_clickDeleteComment);
    on<ClickReplyComment>(_clickReplyComment);
    on<CommentMesChanged>(_mesCommentChanged);
    on<CreateComment>(_createComment);
    on<ClickEditComment>(_clickEditComment);
    on<ClickCancelReply>(_clickCancelReply);
    on<ClickUpdateComment>(_clickUpdateComment);
  }
  final UpdateCommentUsecase _updateCommentUsecase;

  final CreateAnswerUseCase _createAnswerUseCase;
  final LikeAnswerUseCase _likeAnswerUseCase;
  final GetAnswerInQuestionUseCase _getAnswerUseCase;
  final CorrectAnswerUsecase _correctAnswerUsecase;
  final DeleteAnswerUsecase _deleteAnswerUsecase;
  final UnLikeAnswerUsecase _unLikeAnswerUsecase;
  final UpdateAnswerUsecase _updateAnswerUsecase;
  final GetCommentInAnswerUseCase _getCommentInAnswerUsecase;
  final DeleteCommentUsecase _deleteCommentUsecase;
  final CreateCommentInAnswerUsecase _createCommentInAnswerUsecase;
  final LikeCommentUseCase _likeCommentUsecase;
  final UnLikeCommentUsecase _unLikeCommentUsecase;
  Future<void> _clickReplyComment(
      ClickReplyComment event, Emitter<AnswerState> emit) async {
    emit(state.copyWith(
        isComment: true,
        message: '',
        messageController: TextEditingController(text: ''),
        isScrollingDown: true));
    emit(state.copyWith(replyTo: state.answer[event.answerIndex].name));
  }

  FutureOr<void> _scrollDirectionUpdateEvent(
      ScrollDirectionUpdate event, Emitter<AnswerState> emit) {
    emit(state.copyWith(isScrollingDown: event.value));
  }

  Future<void> _clickUpdateComment(
      ClickUpdateComment event, Emitter<AnswerState> emit) async {
    await runAppCatching(
      () async {
        final answer = [...state.answer];
        AnswertEntity currentAnswer = answer[state.answerIndex];
        List<CommentEntity> comments = [...currentAnswer.comments];
        CommentEntity currentComment = comments[state.updateIndex];
        comments[state.updateIndex] =
            currentComment.copyWith(message: state.message);
        answer[state.answerIndex] = currentAnswer.copyWith(comments: comments);
        final message = state.message;
        emit(state.copyWith(
            isComment: false,
            oldMessage: "",
            messageController: TextEditingController(text: ""),
            message: "",
            answer: answer));
        await _updateCommentUsecase.excecute(CommentInput(
            message: message,
            question_id: currentComment.id,
            band_id: currentComment.id));
      },
      onError: (error) async {
        debugPrint("you are running on catch $error");
      },
    );
  }

  Future<void> _clickCancelReply(
      ClickCancelReply event, Emitter<AnswerState> emit) async {
    emit(state.copyWith(
        isComment: false,
        message: '',
        replyTo: '',
        messageController: TextEditingController(text: '')));
    _enableAnswer(emit);
    // emit(state.copyWith(replyTo: state.answer[event.answerIndex].name));
  }

  Future<void> _mesCommentChanged(
      CommentMesChanged event, Emitter<AnswerState> emit) async {
    emit(state.copyWith(message: event.value));
  }

  FutureOr<void> _clickEditComment(
      ClickEditComment event, Emitter<AnswerState> emit) async {
    final answer = [...state.answer];
    AnswertEntity currentAnswer = answer[event.answerIndex];
    List<CommentEntity> comments = [...currentAnswer.comments];

    final oldDes = comments[event.commentIndex].message;
    final mess = state.beforeeditMessage;
    emit(state.copyWith(isComment: true, isScrollingDown: true));
    emit(state.copyWith(
        messageController: TextEditingController(text: oldDes),
        oldMessage: oldDes,
        updateIndex: event.commentIndex,
        answerIndex: event.answerIndex,
        beforeeditMessage: mess,
        message: ""));
    // _enableComment(emit);
  }

  FutureOr<void> _createComment(
      CreateComment event, Emitter<AnswerState> emit) async {
    await runAppCatching(
      () async {
        int answerIndex = state.answerIndex;
        final answer = [...state.answer];
        AnswertEntity currentAnswer = answer[answerIndex];
        List<CommentEntity> comments = [...currentAnswer.comments];
        String des = state.message;
        comments.add(
          CommentEntity(
              date: t.common.justNow,
              message: des,
              name: LocalStorage.getStringValue(SharedPreferenceKeys.name),
              avatar: LocalStorage.getStringValue(SharedPreferenceKeys.avatar),
              isEditDone: true,
              isPostDone: false),
        );
        answer[answerIndex] = currentAnswer.copyWith(
            comments: comments,
            amount_comments: currentAnswer.amount_comments + 1,
            showComment: true);
        emit(state.copyWith(
          answer: answer,
          message: '',
          messageController: TextEditingController(text: ''),
        ));
        final commentNew =
            await _createCommentInAnswerUsecase.excecute(CreateCommnetInAnswer(
          answer_id: currentAnswer.id,
          message: des,
          band_id: 0,
        ));
        final answerafter = [...state.answer];
        AnswertEntity currentAnswerafter = answer[answerIndex];
        List<CommentEntity> commentsafter = [...currentAnswerafter.comments];
        commentsafter.last =
            commentsafter.last.copyWith(isPostDone: true, id: commentNew.id);
        answerafter[answerIndex] =
            answerafter[answerIndex].copyWith(comments: commentsafter);
        emit(state.copyWith(answer: answerafter));
      },
      onError: (error) async {
        debugPrint("error $error");
      },
    );
  }

  FutureOr<void> _clickLikeComment(
      ClickLlikeComment event, Emitter<AnswerState> emit) async {
    final answer = [...state.answer];
    AnswertEntity currentAnswer = answer[event.answerIndex];
    List<CommentEntity> comments = [...currentAnswer.comments];
    CommentEntity currentComment = comments[event.commentIndex];
    await runAppCatching(
      () async {
        final commentLike = currentComment.count_like;
        if (currentComment.is_like == true) {
          comments[event.commentIndex] = currentComment.copyWith(
              count_like: commentLike - 1, is_like: false);
          answer[event.answerIndex] =
              currentAnswer.copyWith(comments: comments);
          emit(state.copyWith(answer: answer));
          await _unLikeCommentUsecase.excecute(currentComment.id);
        } else {
          comments[event.commentIndex] = currentComment.copyWith(
              count_like: commentLike + 1, is_like: true);
          answer[event.answerIndex] =
              currentAnswer.copyWith(comments: comments);
          emit(state.copyWith(answer: answer));
          await _likeCommentUsecase.excecute(currentComment.id);
        }
      },
    );
  }

  FutureOr<void> _clickDeleteComment(
      ClickDeleteComment event, Emitter<AnswerState> emit) async {
    debugPrint("you welcomr ");

    final answer = [...state.answer];
    AnswertEntity currentAnswer = answer[event.answerIndex];
    List<CommentEntity> comments = [...currentAnswer.comments];
    CommentEntity currentComment = comments[event.commentIndex];

    await runAppCatching(
      () async {
        try {
          comments.removeAt(event.commentIndex);
          answer[event.answerIndex] = currentAnswer.copyWith(
              comments: comments,
              amount_comments: currentAnswer.amount_comments - 1);
          emit(state.copyWith(answer: answer));
          await _deleteCommentUsecase.excecute(currentComment.id);
        } catch (value) {
          debugPrint("you have on catch $value");
        }
      },
      onError: (error) async => debugPrint("you $error"),
    );
  }

  FutureOr<void> _clickDownload(
      ClickDownloadImage event, Emitter<AnswerState> emit) async {
    appRoute.pop();
    await saveImage(event.image);
    appRoute.showSuccessSnackBar(t.common.downloadImageSuccess);
  }

  FutureOr<void> _clickUpdate(
      ClickUpdateEvent event, Emitter<AnswerState> emit) async {
    await runAppCatching(
      () async {
        List<AnswertEntity> answer = [...state.answer];
        final currentAnswer = answer[state.updateIndex];
        final message = state.messageController!.text;
        answer[state.updateIndex] = currentAnswer.copyWith(
            description: state.message,
            isEditDone: false,
            file: state.image,
            image: state.urlImage);
        String file = await imageToBase64(state.image);
        if (file.isEmpty) {
          file = state.urlImage;
        }
        final updateImage = state.image;
        emit(
          state.copyWith(
            image: null,
            answer: answer,
            oldMessage: "",
            urlImage: '',
            message: state.beforeeditMessage,
            messageController:
                TextEditingController(text: state.beforeeditMessage),
          ),
        );
        _enableAnswer(emit);
        final newAnswer = await _updateAnswerUsecase.excecute(
          UpdateAnswerInput(
              description: message, id: currentAnswer.id, image: file),
        );
        final answe = [...state.answer];
        // final caa = newAnswer;
        answe[state.updateIndex] =
            newAnswer.copyWith(isEditDone: true, file: updateImage);
        emit(state.copyWith(answer: answe));
      },
      onError: (error) async {
        debugPrint(" fssdfsadf$error");
      },
    );
  }

  FutureOr<void> _clickEdit(
      ClickEditEvent event, Emitter<AnswerState> emit) async {
    try {
      String oldDes = state.answer[event.index].description;
      String urlImage = state.answer[event.index].image;
      final kkk = state.message;
      debugPrint("dddd$urlImage");
      emit(state.copyWith(
          messageController: TextEditingController(text: oldDes),
          oldMessage: oldDes,
          updateIndex: event.index,
          urlImage: urlImage,
          beforeeditMessage: kkk,
          message: kkk));
      _enableAnswer(emit);
    } catch (value) {
      debugPrint("value $value");
    }
  }

  FutureOr<void> _clickGetComment(
      ClickGetComment event, Emitter<AnswerState> emit) async {
    final answer = [...state.answer];
    AnswertEntity currectAnswer = answer[event.index];
    if (currectAnswer.comments.isEmpty) {
      await runAppCatching(
        () async {
          final comment = await _getCommentInAnswerUsecase.excecute(
              GetCommentAnswerInput(answer_id: currectAnswer.id, page: 1));
          currectAnswer =
              currectAnswer.copyWith(comments: comment.data.toListEntity());
          answer[event.index] = currectAnswer.copyWith(showComment: true);
          emit(state.copyWith(answer: answer));
        },
      );
    } else {
      answer[event.index] =
          currectAnswer.copyWith(showComment: !answer[event.index].showComment);
      emit(state.copyWith(answer: answer));
    }
  }

  FutureOr<void> _cancelEdit(
      ClickCancelEditEvent event, Emitter<AnswerState> emit) {
    emit(state.copyWith(
        oldMessage: "",
        messageController: TextEditingController(text: state.beforeeditMessage),
        message: state.beforeeditMessage,
        urlImage: '',
        image: null,
        isComment: false));
    _enableAnswer(emit);
  }

  FutureOr<void> _clickDeleteAnswer(
      ClickDeleteEvent event, Emitter<AnswerState> emit) async {
    bool delete = await ConfirmDeleteAnswerAlert.show(context: event.context);
    if (delete) {
      await runAppCatching(
        () async {
          // appRoute.pop();
          int id = state.answer[event.index].id;
          final answer = [...state.answer];
          answer.removeAt(event.index);
          emit(state.copyWith(answer: answer));
          await _deleteAnswerUsecase.excecute(id);
        },
      );
    }
  }

  FutureOr<void> _clickCorrectAnswer(
      ClickCorrentEvent event, Emitter<AnswerState> emit) async {
    bool isHaveAnotherCorrect =
        state.answer.any((element) => element.is_correct == true);
    final answer = [...state.answer];
    final currentAnswer = answer[event.index];
    final done = await ConfirmAnswerAlert.show(
        context: event.context,
        ontap: () async {},
        isAlreadyCorrect: currentAnswer.is_correct,
        isHaveAnotherCorrect: isHaveAnotherCorrect);
    if (done) {
      await runAppCatching(
        () async {
          if (currentAnswer.is_correct == true) {
            answer[event.index] = currentAnswer.copyWith(is_correct: false);
          } else {
            int ownCorrect = -1;
            ownCorrect =
                answer.indexWhere((element) => element.is_correct == true);
            if (ownCorrect != -1) {
              answer[ownCorrect] = currentAnswer.copyWith(is_correct: false);
            }
            answer[event.index] = currentAnswer.copyWith(is_correct: true);
          }
          int id = state.answer[event.index].id;
          await _correctAnswerUsecase.excecute(id);
          emit(state.copyWith(answer: answer));
        },
      );
    }
  }

  FutureOr<void> _clickLike(
      ClickLikeEvent event, Emitter<AnswerState> emit) async {
    List<AnswertEntity> answer = [...state.answer];
    await runAppCatching(
      () async {
        final correntAnswer = answer[event.index];
        final correntLike = correntAnswer.count_like;
        if (correntAnswer.is_like == true) {
          answer[event.index] = correntAnswer.copyWith(
              count_like: correntLike - 1, is_like: false);
          emit(state.copyWith(answer: answer));

          await _unLikeAnswerUsecase.excecute(correntAnswer.id);
        } else {
          answer[event.index] = correntAnswer.copyWith(
              count_like: correntLike + 1, is_like: true);
          emit(state.copyWith(answer: answer));
          await _likeAnswerUseCase.excecute(correntAnswer.id);
        }
      },
    );
  }

  FutureOr<void> _clickProfile(
      ClickProfileEvent event, Emitter<AnswerState> emit) async {
    appRoute.push(AppRouteInfo.otherProfile(userId: event.userId));
  }

  FutureOr<void> _refreshpage(
      RefreshPage event, Emitter<AnswerState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true, isMorePage: true, page: 1));
        final answerRespose = await _getAnswerUseCase.excecute(
            GetAnswerInput(question_id: event.questionId, page: state.page));
        emit(state.copyWith(
            answer: answerRespose.data.toListEntity(),
            isloading: false,
            page: state.page + 1));
        if (state.page > answerRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _getAnswer(
      GetAnswerEvent event, Emitter<AnswerState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true));
        final answerRespose = await _getAnswerUseCase.excecute(
            GetAnswerInput(question_id: event.questionId, page: state.page));
        final all = [...state.answer];
        all.addAll(answerRespose.data.toListEntity());
        emit(state.copyWith(
            answer: all, isloading: false, page: state.page + 1));
        if (state.page > answerRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _pickImage(
      ClickPickImageEvent event, Emitter<AnswerState> emit) async {
    // final image = await pickImage();
    emit(state.copyWith(image: event.file));
    _enableAnswer(emit);
  }

  void _enableAnswer(Emitter<AnswerState> emit) {
    if ((state.message.isNotEmpty ||
            state.image != null ||
            state.urlImage.isNotEmpty) &&
        (state.message != state.oldMessage || state.image != null)) {
      emit(state.copyWith(enableAnswer: true));
    } else {
      emit(state.copyWith(enableAnswer: false));
    }
    debugPrint("${state.enableAnswer}");
  }
  // void _enableCommnet(Emitter<AnswerState> emit) {}

  FutureOr<void> _clearImage(
      ClickClearImageEvent event, Emitter<AnswerState> emit) async {
    emit(state.copyWith(image: null));
    _enableAnswer(emit);
  }

  FutureOr<void> _onmessageChanged(
      DescriptionChangedEvent event, Emitter<AnswerState> emit) {
    emit(state.copyWith(message: event.text));
    _enableAnswer(emit);
  }

  FutureOr<void> _createAnswer(
      ClcikCreateAnswerEvent event, Emitter<AnswerState> emit) async {
    final answer = [...state.answer];
    answer.insert(
      0,
      AnswertEntity(
          date: t.common.justNow,
          description: state.message,
          name: LocalStorage.getStringValue(SharedPreferenceKeys.name),
          avatar: LocalStorage.getStringValue(SharedPreferenceKeys.avatar),
          id: -1,
          file: state.image,
          isPostDone: false,
          is_your: true),
    );
    String image = await imageToBase64(state.image);
    String message = state.message;
    File? imageSubmit = state.image;
    emit(state.copyWith(
        answer: answer,
        message: "",
        image: null,
        messageController: TextEditingController(text: "")));
    _enableAnswer(emit);
    await runAppCatching(
      () async {
        final answerNew = await _createAnswerUseCase.excecute(CreateAnswerInput(
            description: message,
            question_id: event.questionId,
            image: image,
            band_id: event.bandId));
        List<AnswertEntity> ans = [...state.answer];
        ans.first = answerNew.copyWith(
            isPostDone: true, id: answerNew.id, file: imageSubmit);
        debugPrint("answer first ${ans.first.image}");
        emit(state.copyWith(answer: ans));
      },
      onError: (error) async {
        List<AnswertEntity> ans = [...state.answer];
        final youAnswer = ans.first;
        ans.first = youAnswer.copyWith(isPostDone: true);
        ans.removeAt(0);
        emit(state.copyWith(answer: ans));
      },
    );
  }
}
