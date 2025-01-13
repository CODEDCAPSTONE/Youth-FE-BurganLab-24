import 'package:dio/dio.dart';

class Client {
  static final Dio dio =
      Dio(BaseOptions(baseUrl: 'http://167.71.7.159/api/burgan-assistant'));
}
