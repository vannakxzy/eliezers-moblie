import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/models/security_login/block_model.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../domain/entities/block_entity.dart';
import '../../domain/usecase/get_block_usecase.dart';
import '../../domain/usecase/unblock_usecase.dart';

part 'block_event.dart';
part 'block_state.dart';
part 'block_bloc.freezed.dart';

@Injectable()
class BlockBloc extends BaseBloc<BlockEvent, BlockState> {
  BlockBloc(this._getBlockUseCase, this._unBlockUseCase)
      : super(const BlockState()) {
    on<GetBlockEvent>(_getBlcik);
    on<ClickUnBlockEvent>(_clickUnBlock);
    on<RefreshPage>(_refrashPage);
  }
  final GetBlockUseCase _getBlockUseCase;
  final UnBlockUseCase _unBlockUseCase;

  FutureOr<void> _getBlcik(
      GetBlockEvent event, Emitter<BlockState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));
        final blockRespose = await _getBlockUseCase.excecute(state.page);
        final all = [...state.blocks];
        all.addAll(blockRespose.data!.toListEntity());
        emit(state.copyWith(
            blocks: all, isLoading: false, page: state.page + 1));
        if (state.page > blockRespose.meta!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  FutureOr<void> _refrashPage(
      RefreshPage event, Emitter<BlockState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(page: 1));
        emit(state.copyWith(isLoading: true, isMorePage: true));
        final blockRespose = await _getBlockUseCase.excecute(state.page);
        emit(state.copyWith(
            blocks: blockRespose.data!.toListEntity(),
            isLoading: false,
            page: state.page + 1));
        if (state.page > blockRespose.meta!.lastPage) {
          emit(state.copyWith(isMorePage: false));
        }
      },
      onError: (error) async {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  FutureOr<void> _clickUnBlock(
      ClickUnBlockEvent event, Emitter<BlockState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(isLoading: true));
        final block = [...state.blocks];
        block.removeAt(event.index);
        await _unBlockUseCase.excecute(state.blocks[event.index].id);
        emit(state.copyWith(isLoading: false, blocks: block));
      },
      onError: (error) async {},
    );
  }
}
