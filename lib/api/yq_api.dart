import 'package:dio/dio.dart';

class YqApi {
  late Explore explore;
  late Doc doc;

  static YqApi _instance = YqApi._internal();
  factory YqApi() {
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
  Doc(this._dio);

  Future list({required String namespace}) async {
    return _request(
      _dio.get('/repos/' + namespace + '/docs/'),
    );
  }

  Future get({required String namespace, required String slug}) async {
    return _request(
      _dio.get('/repos/' + namespace + '/docs/' + slug),
    );
  }
}

class Explore {
  Dio _dio;
  Explore(this._dio);

  Future recommends({int limit = 20, int page = 1, String? type}) async {
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
