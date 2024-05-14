import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rhymer/api/models/models.dart';

//part 'api.g.dart';

//flutter packages pub run build_runner build --delete-conflicting-outputs

//@RestApi(baseUrl: '')
abstract class RhymerApiClient {
  factory RhymerApiClient(Dio dio, {String baseUrl}) = _RhymesApiClient;

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

class _RhymesApiClient implements RhymerApiClient {
  _RhymesApiClient(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Rhymes> getRhimesList(String word) async {
    final extra = <String, dynamic>{};
    //final queryParameters = <String, dynamic>{r'word': word};
    final headers = <String, dynamic>{};
    const Map<String, dynamic>? data = null;
    final result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Rhymes>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(
              _dio.options,
              'hs/flutter_1c/rhymes/$word',
              //queryParameters: queryParameters,
              data: data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Rhymes.fromJson(result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
