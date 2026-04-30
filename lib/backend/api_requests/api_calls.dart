import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class ObtenerubicacionCall {
  static Future<ApiCallResponse> call({
    String? latitud = '',
    String? longitud = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'obtenerubicacion',
      apiUrl: 'https://geocode.maps.co/reverse',
      callType: ApiCallType.GET,
      headers: {
        'User-Agent': 'http',
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      params: {
        'lat': latitud,
        'lon': longitud,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GeocodingSearchCall {
  static Future<ApiCallResponse> call({
    String? lat = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'geocodingSearch',
      apiUrl:
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat}&result_type=street_address&key=AIzaSyCACbIy0bWuIC-7loQAuMAcRW6PArf78nA',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

