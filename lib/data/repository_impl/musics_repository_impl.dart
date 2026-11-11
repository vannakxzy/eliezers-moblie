import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../features/musics/domain/entities/music_respose_entity.dart';
import '../../features/musics/domain/repository/musics_repository.dart';
import '../data_sources/remotes/musics_api_service.dart';
import '../models/musics/musics_respose_model.dart';

@LazySingleton(as: MusicsRepository)
class MusicsRepositoryImpl implements MusicsRepository {
  MusicsRepositoryImpl(this._apiServie);
  final MusicsApiServie _apiServie;

  @override
  Future<MusicsResposeEntity> getMusic(int page) async {
    final musics = await _apiServie.getMusics(page);
    return musics.toEntity();
    // return MusicsResposeEntity(
    //     data: musics.data!.toList(), pagination: musics.pagination);
  }

  @override
  Future<void> createFavorite(int id) async {
    return await _apiServie.createFavorites(id);
  }

  @override
  Future<void> deleteFavorite(int id) async {
    await _apiServie.deletefavorite(id);
  }

  @override
  Future<MusicsResposeEntity> searchMusics(String text) async {
    final musics = await _apiServie.searchMusic(text);
    return musics.toEntity();
  }

  @override
  Future<void> createMusic(CreateMusicInput input) async {
    // debugPrint("repo imping");
    await _apiServie.createMusic(input);
  }

  @override
  Future<void> deleteMusic(index) {
    // TODO: implement deleteMusic
    throw UnimplementedError();
  }

  @override
  Future<void> editMusic(CreateMusicInput input) {
    // TODO: implement editMusic
    throw UnimplementedError();
  }
}
