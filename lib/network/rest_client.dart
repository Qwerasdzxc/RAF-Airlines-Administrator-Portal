import 'dart:async';

import 'package:dio/dio.dart';
import 'package:raf_airlines_admin/models/airplane.dart';
import 'package:raf_airlines_admin/models/flight.dart';

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

    _dio.options.baseUrl = "http://localhost:8762/";

    _dio.options.connectTimeout = 90000;
    _dio.options.receiveTimeout = 90000;

    _dio.options.validateStatus = (status) => status < 300 && status >= 200;

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options) async {
      options.headers["Authorization"] = _authorizationToken;

      return options;
    }));
  }

  Future<void> login(String username, String password) async {
    try {
      Response response =
          await _dio.post("raf-airlines-user-service/login", data: {"username": username, "password": password});
      _authorizationToken = response.headers.value("authorization");
    } on DioError catch (e) {
      throw NetworkException(cause: e.message);
    }
  }

  Future<List<Airplane>> getAllAirplanes() async {
    try {
      Response response = await _dio.get("raf-airlines-flight-service/airplane/all");
      return response.data.map<Airplane>((jsonItem) => Airplane.fromJson(jsonItem)).toList();
    } on DioError catch (e) {
      throw NetworkException(cause: e.message);
    }
  }

  Future<Airplane> createAirplane(Airplane airplane) async {
    try {
      Response response = await _dio.post("raf-airlines-flight-service/airplane/add",
          data: {"name": airplane.name, "capacity": airplane.capacity});
      return Airplane.fromJson(response.data);
    } on DioError catch (e) {
      throw NetworkException(cause: e.message);
    }
  }

  FutureOr<void> deleteAirplane(Airplane airplane) async {
    try {
      await _dio.delete("raf-airlines-flight-service/airplane/remove", queryParameters: {"airplaneId": airplane.id});
    } on DioError catch (e) {
      throw NetworkException(cause: e.message);
    }
  }

  Future<List<Flight>> getAllFlights() async {
    try {
      Response response = await _dio.get("raf-airlines-flight-service/flight/all");
      return response.data.map<Flight>((jsonItem) => Flight.fromJson(jsonItem)).toList();
    } on DioError catch (e) {
      throw NetworkException(cause: e.message);
    }
  }

  Future<Flight> createFlight(Flight flight) async {
    try {
      Response response = await _dio.post("raf-airlines-flight-service/flight/add", data: {
        "airplaneId": flight.airplane.id,
        "startDestination": flight.startDestination,
        "endDestination": flight.endDestination,
        "distance": flight.distance,
        "price": flight.price
      });
      return Flight.fromJson(response.data);
    } on DioError catch (e) {
      throw NetworkException(cause: e.message);
    }
  }

  FutureOr<void> deleteFlight(Flight flight) async {
    try {
      await _dio.delete("raf-airlines-flight-service/flight/delete", queryParameters: {"flightId": flight.id});
    } on DioError catch (e) {
      throw NetworkException(cause: e.message);
    }
  }
}
