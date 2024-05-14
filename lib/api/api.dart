import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rhymer/api/models/models.dart';

part 'api.g.dart';

//flutter packages pub run build_runner build --delete-conflicting-outputs

@RestApi(baseUrl: '')
abstract class RhymerApiClient {
  factory RhymerApiClient(Dio dio, {String baseUrl}) = _RhymerApiClient;

  factory RhymerApiClient.create({String? apiURL}) {
    final dio = Dio();
    if (apiURL != null) {
      return RhymerApiClient(dio, baseUrl: apiURL);
    }
    return RhymerApiClient(
      dio,
    );
  }

  @GET('{word}')
  Future<Rhymes> getRhimesList(@Path('word') String word);
}
