import '../entities/music_respose_entity.dart';

abstract class MusicsRepository {
  Future<MusicsResposeEntity> getMusic(int page);
  Future<void> createFavorite(int id);
  Future<void> deleteFavorite(int id);
}
