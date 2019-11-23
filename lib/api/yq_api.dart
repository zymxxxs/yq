import 'package:dio/dio.dart';

class YqApi {
  Explore explore;
  Doc doc;

  static YqApi _instance;
  factory YqApi() {
    if (_instance == null) {
      _instance = YqApi._internal();
    }
    return _instance;
  }

  YqApi._internal() {
    Dio dio = Dio();
    dio.options.baseUrl = 'https://www.yuque.com/api/v2';
    this.explore = Explore(dio);
    this.doc = Doc(dio);
  }
}

class Doc {
  Dio _dio;
  Doc(dio) {
    this._dio = dio;
  }

  Future list({String namespace}) async {
    return _request(
      _dio.get('/repos/' + namespace + '/docs/'),
    );
  }

  Future get({String namespace, String slug}) async {
    return _request(
      _dio.get('/repos/' + namespace + '/docs/' + slug),
    );
  }
}

class Explore {
  Dio _dio;
  Explore(dio) {
    this._dio = dio;
  }

  Future recommends({int limit = 20, int page = 1, String type}) async {
    return _request(
      _dio.get(
        'https://www.yuque.com/api/explore/recommends',
        queryParameters: {
          'limit': limit.toString(),
          'page': page.toString(),
          'type': type ?? ""
        },
      ),
    );
  }

  Future selections({int limit = 20, page = 1}) async {
    return _request(
      _dio.get(
        'https://www.yuque.com/api/explore/selections',
        queryParameters: {'limit': limit.toString(), 'page': page.toString()},
      ),
    );
  }

  Future books({int limit = 20}) async {
    return _request(
      _dio.get(
        'https://www.yuque.com/api/explore/books',
        queryParameters: {
          'limit': limit.toString(),
        },
      ),
    );
  }

  Future docs({int limit = 20}) async {
    return _request(
      _dio.get(
        'https://www.yuque.com/api/explore/docs',
        queryParameters: {
          'limit': limit.toString(),
        },
      ),
    );
  }
}

Future<dynamic> _request(Future<Response> f) async {
  Response res = await f;
  if (res.data is Map) {
    Map data = res.data;
    return data['data'];
  }
  return {};
}

class BaseApi {}
