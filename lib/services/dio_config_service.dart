import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio? dioInstance;
createInstance() async {

  var options = BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      connectTimeout: 12000,
      receiveTimeout: 12000,
      queryParameters: {
        "api_key": "f2e58427348f0cdfefa721f58ba7cc0e",
        "language": "en-US",
      },
      headers: {
        // "x-rapidapi-key": "6af4f77398mshb3f6cd027729468p1d6d31jsn038947888a17",
        // "x-rapidapi-host": "imdb8.p.rapidapi.com"
        // "api_key":"f2e58427348f0cdfefa721f58ba7cc0e",
      });
      
  dioInstance = new Dio(options);
  dioInstance!.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));

}

Future<Dio?> dio() async {
  await createInstance();
  dioInstance!.options.baseUrl = "https://api.themoviedb.org/3";
  return dioInstance;
}

