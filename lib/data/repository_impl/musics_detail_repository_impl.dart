import 'package:injectable/injectable.dart';

import '../../features/musics_detail/domain/repository/song_detail_repository.dart'
    show SongDetailRepository;

@LazySingleton(as: SongDetailRepository)
class SongDetailRepositoryImpl implements SongDetailRepository {}
