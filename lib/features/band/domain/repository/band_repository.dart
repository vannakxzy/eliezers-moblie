import '../../../../data/data_sources/remotes/band_api_service.dart';
import '../../../home/domain/entities/question_respose_entity.dart';
import '../entities/band_entity.dart';
import '../entities/band_member_respose_entity.dart';
import '../entities/band_respose_entity.dart';

abstract class BandRepository {
  Future<void> getOwnPermissionband(int input);
  Future<BandEntity> findband(int input);
  Future<BandResposeEntity> getband(GetbandInput input);
  Future<BandResposeEntity> getbandInUser(GetbandInUserInput input);
  Future<BandEntity> createband(bandInput input);
  Future<void> joinband(int input);
  Future<void> readMessage(int input);
  Future<void> requestToJoinband(int input);
  Future<QuestionResposeEntity> getQuestionInband(bandIdPageInput input);
  Future<BandMemberResposeEntity> getbandMember(bandIdPageInput input);
  Future<void> approveUserInband(BandIdUserIdInput input);
  Future<void> rejectUserInband(BandIdUserIdInput input);
  Future<void> leaveband(int input);
  Future<BandResposeEntity> searchband(SearchInput input);
  Future<void> updatebandRole(bandMemberInput input);
  Future<void> updateband(bandInput input);
  Future<void> updateCommunitPermission(bandPermissionInput input);
  Future<void> deleteband(int input);
  Future<void> cancenlRequest(int input);
  Future<void> removeMemberband(BandIdUserIdInput input);
  Future<void> addMember(AddbandMemberInput input);
  Future<BandMemberResposeEntity> getAllRequest(SearchInput input);
}
