import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/shared_preference_keys_constants.dart';
import '../../../../core/helper/fuction.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../data/data_sources/remotes/answer_api_service.dart';
import '../../../../data/data_sources/remotes/comment_in_answer_api_service.dart';
import '../../../../data/data_sources/remotes/comment_in_question_api_service.dart';
import '../../../../data/models/profile/answer_model.dart';
import '../../../../data/models/question_detail/comment_model.dart';
import '../../../answer/alert/confirm_correct_answer_alert.dart';
import '../../../answer/domain/usecase/create_answer_usercase.dart';
import '../../../answer/domain/usecase/delete_answer_usecase.dart';
import '../../../answer/domain/usecase/update_answer_usecase.dart';
import '../../../comment_in_answer/domain/usecase/create_comment_in_answer_usecase.dart';
import '../../../comment_in_answer/domain/usecase/get_comment_in_answer_usecase.dart';
import '../../../comment_in_question/domain/usecase/delete_comment_usecase.dart';
import '../../../comment_in_question/domain/usecase/like_comment_usecase.dart';
import '../../../comment_in_question/domain/usecase/un_like_comment_usecase.dart';
import '../../../comment_in_question/domain/usecase/update_comment_usecase.dart';
import '../../../comment_in_question/presentation/pages/comment_in_question_page.dart';
import '../../../home/domain/entities/question_entity.dart';
import '../../../home/domain/usecase/like_question_usecase.dart';
import '../../../home/domain/usecase/un_like_question_usecase.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/usecase/delete_question_usecase.dart';
import '../../domain/usecase/like_answer_usecase.dart';
import '../../domain/usecase/un_like_answer_usecase.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../profile/domain/entities/answer_entity.dart';
import '../../../security_login/domain/usecase/create_block_usercase.dart';
import '../../domain/usecase/correct_answer_usecase.dart';
import '../../../answer/domain/usecase/get_answer_in_question_usecase.dart';
import '../../domain/usecase/get_question_by_id.dart';

part 'question_detail_event.dart';
part 'question_detail_state.dart';
part 'question_detail_bloc.freezed.dart';

@Injectable()
class QuestionDetailBloc
    extends BaseBloc<QuestionDetailEvent, QuestionDetailState> {
  QuestionDetailBloc(
      this._getAnswerUseCase,
      // this._createHideUsercase,
      this._deleteQuestionUsecase,
      this._deleteAnswerUsecase,
      this._createBlockUseCase,
      this._getQuestionByIdUseCase,
      this._likeAnswerUseCase,
      this._unLikeAnswerUsecase,
      this._createAnswerUseCase,
      this._unlikeQuestion,
      this._correctAnswerUsecase,
      this._likeQuestionUseCase,
      this._updateAnswerUsecase,
      this._getCommentInAnswerUsecase,
      this._updateCommentUsecase,
      this._deleteCommentUsecase,
      this._createCommentInAnswerUsecase,
      this._likeCommentUsecase,
      this._unLikeCommentUsecase)
      : super(const QuestionDetailState()) {
    on<InitPage>(_initPage);
    on<ClickProfileEvent>(_clickProfile);
    on<ClickBlockUserEvent>(_clickBlock);
    on<GetAnswerInDiscussionEvent>(_getAnswerInQuestion);
    on<RefresPageEvent>(_refreshpage);
    on<ClickLikeAnswerEvent>(_ClickLikeAnswer);
    on<ClickDownloadPhoroEvent>(_clickDownloadImageDiscussion);
    on<ClickShare>(_clickShare);
    on<ClickDeleteDiscusstionEvent>(_clickDeleteDiscussion);
    on<MessageChangedEvent>(_desChanged);
    on<ClickPickImageEvent>(_pickImage);
    on<ClickClearImageEvent>(_clearImage);
    on<ClickCancelEdit>(_clickCancelEdit);
    on<ClickDeleteAnswer>(_deleteAnswer);
    on<ClcikPostDiscussion>(_clcikPostDiscussion);
    on<ClickEditAnswer>(_clickEditAnswer);
    on<ClickUpdateAnswer>(_clickUpdateAnswer);
    on<ClickUpdateQuestion>(_updateQuestion);
    on<GetDiscussionByIdEvent>(_getQuestionById);
    on<ClickLikeDiscussion>(_clickLikeDisscussion);
    on<ScrollDirectionUpdate>(_scrollDirectionUpdateEvent);
    on<ListionScroll>(_listionScroll);
    on<ClickGetComment>(_clickGetComment);
    on<ClickCorrent>(_clickCorrectAnswer);
    on<CreateComment>(_createComment);
    on<ClickEditComment>(_clickEditComment);
    on<ClickCancelReply>(_clickCancelReply);
    on<ClickUpdateComment>(_clickUpdateComment);

    on<ClickLlikeComment>(_clickLikeComment);
    on<ClickDeleteComment>(_clickDeleteComment);
    on<ClickReplyComment>(_clickReplyComment);
    on<ClickSeeAllCommentInQuestion>(_clickSeeAllCommentInQuestion);
  }
  final CorrectAnswerUsecase _correctAnswerUsecase;

  final CreateAnswerUseCase _createAnswerUseCase;
  final GetAnswerInQuestionUseCase _getAnswerUseCase;
  final DeleteQuestionUsecase _deleteQuestionUsecase;
  final DeleteAnswerUsecase _deleteAnswerUsecase;
  final CreateBlockUseCase _createBlockUseCase;
  final GetCommentInAnswerUseCase _getCommentInAnswerUsecase;
  final GetQuestionByIdUseCase _getQuestionByIdUseCase;
  final LikeAnswerUseCase _likeAnswerUseCase;
  final UpdateAnswerUsecase _updateAnswerUsecase;
  final UnLikeAnswerUsecase _unLikeAnswerUsecase;
  final UnLikeQuestion _unlikeQuestion;
  final LikeQuestionUseCase _likeQuestionUseCase;
  final UpdateCommentUsecase _updateCommentUsecase;
  final DeleteCommentUsecase _deleteCommentUsecase;
  final CreateCommentInAnswerUsecase _createCommentInAnswerUsecase;
  final LikeCommentUseCase _likeCommentUsecase;
  final UnLikeCommentUsecase _unLikeCommentUsecase;

  Future<void> _clickReplyComment(
      ClickReplyComment event, Emitter<QuestionDetailState> emit) async {
    emit(state.copyWith(
        isComment: true,
        message: '',
        isScrollingDown: true,
        messageController: TextEditingController(text: '')));
    emit(state.copyWith(replyTo: state.answer[event.answerIndex].name));
  }

  Future<void> _clickSeeAllCommentInQuestion(ClickSeeAllCommentInQuestion event,
      Emitter<QuestionDetailState> emit) async {
    int valueUpdated = await CommentInQuestionBottomSheet.show(
        context: event.context, id: event.questionId);
    debugPrint("value update $valueUpdated");
    int currentComment = state.question.amountComments;
    emit(state.copyWith(
        question: state.question
            .copyWith(amountComments: currentComment + valueUpdated)));
  }

  Future<void> _clickUpdateComment(
      ClickUpdateComment event, Emitter<QuestionDetailState> emit) async {
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
      ClickCancelReply event, Emitter<QuestionDetailState> emit) async {
    emit(state.copyWith(
        isComment: false,
        message: '',
        replyTo: '',
        messageController: TextEditingController(text: '')));
    // _enableAnswer(emit);
    // emit(state.copyWith(replyTo: state.answer[event.answerIndex].name));
  }

  FutureOr<void> _clickEditComment(
      ClickEditComment event, Emitter<QuestionDetailState> emit) async {
    final answer = [...state.answer];
    AnswertEntity currentAnswer = answer[event.answerIndex];
    List<CommentEntity> comments = [...currentAnswer.comments];

    final oldDes = comments[event.commentIndex].message;
    final mess = state.beforeeditMessage;
    emit(state.copyWith(isComment: true));
    emit(state.copyWith(
        messageController: TextEditingController(text: oldDes),
        oldMessage: oldDes,
        updateIndex: event.commentIndex,
        isScrollingDown: true,
        answerIndex: event.answerIndex,
        beforeeditMessage: mess,
        message: ""));
    // _enableComment(emit);
  }

  FutureOr<void> _createComment(
      CreateComment event, Emitter<QuestionDetailState> emit) async {
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
      ClickLlikeComment event, Emitter<QuestionDetailState> emit) async {
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
      ClickDeleteComment event, Emitter<QuestionDetailState> emit) async {
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

  FutureOr<void> _clickGetComment(
      ClickGetComment event, Emitter<QuestionDetailState> emit) async {
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

  FutureOr<void> _initPage(InitPage event, Emitter<QuestionDetailState> emit) {
    if (event.question == QuestionEntity()) {
      add(GetDiscussionByIdEvent(event.discussionId));
      add(GetAnswerInDiscussionEvent(event.discussionId));
    } else {
      emit(state.copyWith(question: event.question));
      add(GetAnswerInDiscussionEvent(event.question.id));
    }
  }

  FutureOr<void> _clickLikeDisscussion(
      ClickLikeDiscussion event, Emitter<QuestionDetailState> emit) async {
    debugPrint("sdfdsf");

    QuestionEntity currentDiscussion = state.question;
    final currentLike = currentDiscussion.countLike;
    if (currentDiscussion.is_like) {
      currentDiscussion = currentDiscussion.copyWith(
          countLike: currentLike - 1, is_like: false);
      emit(state.copyWith(question: currentDiscussion));
      await _unlikeQuestion.excecute(currentDiscussion.id);
    } else {
      currentDiscussion =
          currentDiscussion.copyWith(countLike: currentLike + 1, is_like: true);
      emit(state.copyWith(question: currentDiscussion));
      await _likeQuestionUseCase.excecute(currentDiscussion.id);
    }
  }

  FutureOr<void> _getQuestionById(
      GetDiscussionByIdEvent event, Emitter<QuestionDetailState> emit) async {
    debugPrint("fasfsaf");
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true));
        final question = await _getQuestionByIdUseCase.excecute(event.id);
        emit(state.copyWith(isloading: false, question: question));
      },
      onError: (error) async {
        debugPrint("get question by id  error $error");
        emit(state.copyWith(isloading: false));
      },
    );
  }

  FutureOr<void> _scrollDirectionUpdateEvent(
      ScrollDirectionUpdate event, Emitter<QuestionDetailState> emit) {
    emit(state.copyWith(isScrollingDown: event.value));
  }

  FutureOr<void> _listionScroll(
      ListionScroll event, Emitter<QuestionDetailState> emit) {
    if (event.value > 100) {
      emit(state.copyWith(showBackground: true));
    } else {
      emit(state.copyWith(showBackground: false));
    }
  }

  FutureOr<void> _clcikPostDiscussion(
      ClcikPostDiscussion event, Emitter<QuestionDetailState> emit) async {
    debugPrint("you have annooooo ");
    final answer = [...state.answer];
    QuestionEntity question = state.question;
    question =
        question.copyWith(amountAnswers: state.question.amountAnswers + 1);
    answer.insert(
      0,
      AnswertEntity(
          date: t.common.justNow,
          description: state.message,
          name: LocalStorage.getStringValue(SharedPreferenceKeys.name),
          avatar: LocalStorage.getStringValue(SharedPreferenceKeys.avatar),
          id: -1,
          file: state.file,
          isPostDone: false,
          is_your: true),
    );
    String image = await imageToBase64(state.file);
    String message = state.message;
    File? imageSubmit = state.file;
    emit(state.copyWith(
        question: question,
        answer: answer,
        message: "",
        file: null,
        messageController: TextEditingController(text: "")));
    _enablePostDiscussion(emit);
    await runAppCatching(
      () async {
        final answerNew = await _createAnswerUseCase.excecute(CreateAnswerInput(
            band_id: event.bandId,
            description: message,
            question_id: event.discussionId,
            image: image));
        List<AnswertEntity> ans = [...state.answer];
        ans.first = answerNew.copyWith(
            isPostDone: true, id: answerNew.id, file: imageSubmit);
        debugPrint("answer first ${ans.first.image}");
        emit(state.copyWith(answer: ans));
      },
      onError: (error) async {
        debugPrint("you have been got error $error");
        List<AnswertEntity> ans = [...state.answer];
        final youAnswer = ans.first;
        ans.first = youAnswer.copyWith(isPostDone: true);
        ans.removeAt(0);
        emit(state.copyWith(answer: ans));
      },
    );
  }

  FutureOr<void> _clickCancelEdit(
      ClickCancelEdit event, Emitter<QuestionDetailState> emit) {
    debugPrint("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPp");
    emit(state.copyWith(
      file: null,
      oldMessage: "",
      urlImage: "",
      messageController: TextEditingController(text: ""),
      message: "",
    ));
  }

  void _enablePostDiscussion(Emitter<QuestionDetailState> emit) {
    if ((state.message.isNotEmpty ||
            state.file != null ||
            state.urlImage.isNotEmpty) &&
        (state.message != state.oldMessage || state.file != null)) {
      emit(state.copyWith(enableAnswer: true));
    } else {
      emit(state.copyWith(enableAnswer: false));
    }
    debugPrint("${state.enableAnswer}");
  }

  FutureOr<void> _clickBlock(
      ClickBlockUserEvent event, Emitter<QuestionDetailState> emit) async {
    await runAppCatching(
      () async {
        await _createBlockUseCase.excecute(event.userId);
        appRoute.showInfoSnackBar(t.common.blockUserSuccess);
      },
      onError: (error) async {
        debugPrint("eroro $error");
      },
    );
  }

  FutureOr<void> _clickProfile(
      ClickProfileEvent event, Emitter<QuestionDetailState> emit) async {
    appRoute.push(AppRouteInfo.otherProfile(userId: event.userId));
  }

  FutureOr<void> _refreshpage(
      RefresPageEvent event, Emitter<QuestionDetailState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true, isMorePage: true, page: 1));
        final answerRespose = await _getAnswerUseCase.excecute(
            GetAnswerInput(question_id: state.question.id, page: state.page));
        emit(state.copyWith(
            answer: answerRespose.data.toListEntity(),
            isloading: false,
            page: state.page + 1));
        if (state.page > answerRespose.mate!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(
          isloading: false,
        ));
      },
    );
  }

  FutureOr<void> _clickUpdateAnswer(
      ClickUpdateAnswer event, Emitter<QuestionDetailState> emit) async {
    await runAppCatching(
      () async {
        List<AnswertEntity> answer = [...state.answer];
        final currentAnswer = answer[state.updateIndex];
        final message = state.messageController!.text;
        answer[state.updateIndex] = currentAnswer.copyWith(
            description: state.message,
            isEditDone: false,
            file: state.file,
            image: state.urlImage);
        String file = await imageToBase64(state.file);
        if (file.isEmpty) {
          file = state.urlImage;
        }
        final updateImage = state.file;
        emit(
          state.copyWith(
            file: null,
            answer: answer,
            oldMessage: "",
            urlImage: '',
            message: state.beforeeditMessage,
            messageController:
                TextEditingController(text: state.beforeeditMessage),
          ),
        );
        _enablePostDiscussion(emit);
        final newAnswer = await _updateAnswerUsecase.excecute(
          UpdateAnswerInput(
              description: message, id: currentAnswer.id, image: file),
        );

        final answe = [...state.answer];
        answe[state.updateIndex] =
            newAnswer.copyWith(isEditDone: true, file: updateImage);
        emit(state.copyWith(answer: answe));
      },
      onError: (error) async {
        debugPrint("you have on error $error");
      },
    );
  }

  FutureOr<void> _updateQuestion(
      ClickUpdateQuestion event, Emitter<QuestionDetailState> emit) async {
    emit(state.copyWith(question: event.question));
    // debugPrint()
  }

  FutureOr<void> _pickImage(
      ClickPickImageEvent event, Emitter<QuestionDetailState> emit) async {
    emit(state.copyWith(file: event.file));
    _enablePostDiscussion(emit);
  }

  FutureOr<void> _clearImage(
      ClickClearImageEvent event, Emitter<QuestionDetailState> emit) async {
    emit(state.copyWith(file: null));
    _enablePostDiscussion(emit);
  }

  FutureOr<void> _desChanged(
      MessageChangedEvent event, Emitter<QuestionDetailState> emit) {
    emit(state.copyWith(message: event.value));
    _enablePostDiscussion(emit);
  }

  FutureOr<void> _clickEditAnswer(
      ClickEditAnswer event, Emitter<QuestionDetailState> emit) async {
    String oldDes = state.answer[event.index].description;
    String urlImage = state.answer[event.index].image;
    emit(state.copyWith(
      messageController: TextEditingController(text: oldDes),
      oldMessage: oldDes,
      urlImage: urlImage,
      message: "",
    ));
  }

  FutureOr<void> _deleteAnswer(
      ClickDeleteAnswer event, Emitter<QuestionDetailState> emit) async {
    await runAppCatching(
      () async {
        // appRoute.pop();
        final question = state.question
            .copyWith(amountAnswers: state.question.amountAnswers - 1);
        final answer = [...state.answer];
        final answerId = answer[event.index].id;
        answer.removeAt(event.index);
        emit(state.copyWith(answer: answer, question: question));
        await _deleteAnswerUsecase.excecute(answerId);
      },
      onError: (error) async {
        debugPrint("you have been error : $error");
      },
    );
  }

  FutureOr<void> _clickDeleteDiscussion(ClickDeleteDiscusstionEvent event,
      Emitter<QuestionDetailState> emit) async {
    await runAppCatching(
      () async {
        await _deleteQuestionUsecase.excecute(event.questionId);
        // appRoute.showInfoSnackBar(t.de.deleteSuccess);
      },
    );
  }

  FutureOr<void> _clickCorrectAnswer(
      ClickCorrent event, Emitter<QuestionDetailState> emit) async {
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
            emit(state.copyWith(
                question: state.question.copyWith(isTrue: false)));
          } else {
            int ownCorrect = -1;
            ownCorrect =
                answer.indexWhere((element) => element.is_correct == true);
            if (ownCorrect != -1) {
              answer[ownCorrect] =
                  answer[ownCorrect].copyWith(is_correct: false);
            }
            answer[event.index] =
                answer[event.index].copyWith(is_correct: true);
            emit(state.copyWith(
                question: state.question.copyWith(isTrue: true)));
          }
          int id = state.answer[event.index].id;
          await _correctAnswerUsecase.excecute(id);
          emit(state.copyWith(answer: answer));
        },
      );
    }
  }

  FutureOr<void> _getAnswerInQuestion(GetAnswerInDiscussionEvent event,
      Emitter<QuestionDetailState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isloading: true, isMorePage: true, page: 1));
        final answerRespose = await _getAnswerUseCase
            .excecute(GetAnswerInput(question_id: event.id, page: state.page));
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

  // FutureOr<void> _clickHide(
  //     ClickHideEvent event, Emitter<QuestionDetailState> emit) async {
  //   await runAppCatching(() async {
  //     appRoute.pop();
  //     await _createHideUsercase.excecute(event.questionId);
  //     appRoute.showInfoSnackBar(t.common.hideSuccess);
  //   });
  // }

  FutureOr<void> _clickDownloadImageDiscussion(
      ClickDownloadPhoroEvent event, Emitter<QuestionDetailState> emit) async {
    await saveImage(event.urlImage);
    appRoute.showSuccessSnackBar(t.common.downloadImageSuccess);
  }

  FutureOr<void> _ClickLikeAnswer(
      ClickLikeAnswerEvent event, Emitter<QuestionDetailState> emit) async {
    final answer = [...state.answer];
    final currentAnswer = answer[event.index];
    final currentLike = currentAnswer.count_like;
    if (currentAnswer.is_like == false) {
      answer[event.index] =
          currentAnswer.copyWith(count_like: currentLike + 1, is_like: true);
      emit(state.copyWith(answer: answer));
      await _likeAnswerUseCase.excecute(currentAnswer.id);
    } else {
      answer[event.index] =
          currentAnswer.copyWith(count_like: currentLike - 1, is_like: false);
      emit(state.copyWith(answer: answer));

      await _unLikeAnswerUsecase.excecute(currentAnswer.id);
    }
  }

  FutureOr<void> _clickShare(
      ClickShare event, Emitter<QuestionDetailState> emti) async {
    await shareDiscussion(event.question);
  }
}
