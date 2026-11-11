import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/api_constants.dart';
import '../../models/musics/musics_respose_model.dart';

part 'musics_api_service.g.dart';

@LazySingleton()
@RestApi()
abstract class MusicsApiServie {
  @FactoryMethod()
  factory MusicsApiServie(Dio dio) = _MusicsApiServie;

  @GET(ApiEndpoints.musics)
  Future<MusicsResposeModel> getMusics(
    @Query("page") int page,
  );

  @POST("${ApiEndpoints.favoriteMusics}/{id}")
  Future<void> createFavorites(@Path("id") int id);

  @DELETE("${ApiEndpoints.favoriteMusics}/{id}")
  Future<void> deletefavorite(@Path("id") int id);

  @GET("${ApiEndpoints.musics}/search")
  Future<MusicsResposeModel> searchMusic(
    @Query("q") String q,
  );

  @POST(ApiEndpoints.musics)
  Future<void> createMusic(
    @Body() CreateMusicInput input,
  );
}
@JsonSerializable()
class CreateMusicInput {
  final String title;
  final String artist;
  final String album;
  final String lead_sheet;
  final String audio;
  final String chord_sheet;
  final String cover;
  final String description;

  CreateMusicInput({
    required this.title,
    required this.description,
    required this.cover,
    required this.album,
    this.chord_sheet = "",
    required this.artist,
    required this.audio,
    required this.lead_sheet,
  });

  factory CreateMusicInput.fromJson(Map<String, dynamic> json) =>
      _$CreateMusicInputFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMusicInputToJson(this);
}
