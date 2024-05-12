import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rhymer/api/models/models.dart';

part 'api.g.dart';

//flutter packages pub run build_runner build --delete-conflicting-outputs

@RestApi(baseUrl: '')
abstract class RhimerApiClient {
  factory RhimerApiClient(Dio dio, {String baseUrl}) = _RhimerApiClient;

  factory RhimerApiClient.create({String? apiURL}) {
    final dio = Dio();
    if (apiURL != null) {
      return RhimerApiClient(dio, baseUrl: apiURL);
    }
    return RhimerApiClient(
      dio,
    );
  }

  @GET('/rhimes/get')
  Future<Rhimes> getRhimesList(@Query('word') String word);
}
