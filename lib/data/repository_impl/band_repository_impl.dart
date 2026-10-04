import 'package:injectable/injectable.dart';

import '../../features/band/domain/entities/band_entity.dart';
import '../../features/band/domain/entities/band_member_respose_entity.dart';
import '../../features/band/domain/entities/band_respose_entity.dart';
import '../../features/band/domain/repository/band_repository.dart';
import '../../features/home/domain/entities/question_respose_entity.dart';
import '../data_sources/remotes/band_api_service.dart';
import '../models/band/band_member_respose_model.dart';
import '../models/band/band_model.dart';
import '../models/band/band_respose_model.dart';
import '../models/homes/question_respose_model.dart';

@LazySingleton(as: BandRepository)
class BandRepositoryImpl implements BandRepository {
  final BandApiService _service;
  BandRepositoryImpl(this._service);
  @override
  Future<BandEntity> createband(bandInput input) async {
    final respose = await _service.createband(input: input);
    return respose.toEntity();
  }

  @override
  Future<BandResposeEntity> getband(GetbandInput input) async {
    final response = await _service.getband(input: input);
    return response.toEntity();
  }

  @override
  Future<BandResposeEntity> getbandInUser(GetbandInUserInput input) async {
    final response = await _service.getbandInUser(input: input);
    return response.toEntity();
  }

  @override
  Future<void> approveUserInband(BandIdUserIdInput input) async {
    await _service.approveUserInband(input: input);
  }

  @override
  Future<void> joinband(int input) async {
    await _service.joinband(band_id: input);
  }

  @override
  Future<void> leaveband(int input) async {
    await _service.leaveband(band_id: input);
  }

  @override
  Future<void> rejectUserInband(BandIdUserIdInput input) async {
    await _service.rejectUserInband(input: input);
  }

  @override
  Future<void> removeMemberband(BandIdUserIdInput input) async {
    await _service.removeMemberband(input: input);
  }

  @override
  Future<void> requestToJoinband(int input) async {
    await _service.requestToJoinband(band_id: input);
  }

  @override
  Future<void> getOwnPermissionband(int input) async {
    await _service.getOwnPermissionInband(band_id: input);
  }

  @override
  Future<void> updatebandRole(bandMemberInput input) async {
    await _service.updatebandRole(input: input);
  }

  @override
  Future<BandResposeEntity> searchband(SearchInput input) async {
    final response = await _service.searchband(input: input);
    return response.toEntity();
  }

  @override
  Future<QuestionResposeEntity> getQuestionInband(bandIdPageInput input) async {
    final response = await _service.getQuestionInband(input: input);
    return response.toEntity();
  }

  @override
  Future<void> deleteband(int input) async {
    await _service.deleteband(input);
  }

  @override
  Future<void> updateCommunitPermission(bandPermissionInput input) async {
    await _service.updateCommunitPermission(input: input);
  }

  @override
  Future<void> updateband(bandInput input) async {
    await _service.updateband(input: input);
  }

  @override
  Future<BandMemberResposeEntity> getbandMember(bandIdPageInput input) async {
    final response = await _service.getbandMember(input: input);
    return response.toEntity();
  }

  @override
  Future<void> addMember(AddbandMemberInput input) async {
    await _service.addMember(input: input);
  }

  @override
  Future<void> cancenlRequest(int input) async {
    await _service.cancelReqeustband(band_id: input);
  }

  @override
  Future<BandMemberResposeEntity> getAllRequest(SearchInput input) async {
    final response = await _service.gerAllRequest(input: input);
    return response.toEntity();
  }

  @override
  Future<void> readMessage(int input) async {
    await _service.readMessage(input);
  }

  @override
  Future<BandEntity> findband(int input) async {
    final response = await _service.findCommuntiy(input);
    return response.toEntity();
  }
}
