// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';

class ApiConnexion
{
  static const String baseUrl = 'http://196.201.197.83:8535/cnssapidjibouti/public/api';

  BaseOptions baseOptions()
  {
    return BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
  }
}