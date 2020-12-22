import 'package:dio/dio.dart';
import 'network_exception.dart';

class RestClient {

  Dio _dio;

  String _authorizationToken;

  static final RestClient _singleton = RestClient._internal();

  factory RestClient() {
    return _singleton;
  }

  RestClient._internal() {
    init();
  }

  void init() async {
    _dio = Dio();

    _dio.options.baseUrl = "http://localhost:8080/";

    _dio.options.connectTimeout = 90000;
    _dio.options.receiveTimeout = 90000;

    _dio.options.validateStatus = (status) => status < 300 && status >= 200;

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options) async {
        options.headers["Authorization"] = _authorizationToken;
        options.headers["Content-Type"] = "application/json";

        return options;
      }
    ));
  }
  
  Future<void> login(String username, String password) async {
    try {
      Response response = await _dio.post("login", data: {"username": username, "password": password});
      _authorizationToken = response.headers.value("authorization");
    } on DioError catch (e) {
      throw NetworkException(cause: e.message);
    }
  }
}