import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:majootestcase/models/movie.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/services/dio_config_service.dart' as dioConfig;

class ApiServices{

  Future<MovieResponse?> getMovieList() async {
    try {
      var dio = await dioConfig.dio();
      Response<String> response  = await dio!.get("/movie/now_playing");
      MovieResponse? movieResponse = MovieResponse.fromJson(jsonDecode(response.data.toString()));
      return movieResponse;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}