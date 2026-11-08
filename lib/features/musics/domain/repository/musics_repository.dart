import '../../../../data/data_sources/remotes/musics_api_service.dart';
import '../entities/music_respose_entity.dart';

abstract class MusicsRepository {
  Future<MusicsResposeEntity> getMusic(int page);
  Future<void> createFavorite(int id);
  Future<void> deleteFavorite(int id);
  Future<MusicsResposeEntity> searchMusics(String text);
  Future<void> createMusic(CreateMusicInput input);
  Future<void> editMusic(CreateMusicInput input);
  Future<void> deleteMusic(index);
}
