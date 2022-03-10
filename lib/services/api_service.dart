import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:majootestcase/models/movie.dart';
import 'package:majootestcase/models/movie_detail.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/models/tv_detail.dart';
import 'package:majootestcase/services/dio_config_service.dart' as dioConfig;

class ApiServices {
  Future<MovieResponse?> getNowPlayingMovies() async {
    try {
      var dio = await dioConfig.dio();
      Response<String> response = await dio!.get("/movie/now_playing");
      MovieResponse? movieResponse =
          MovieResponse.fromJson(jsonDecode(response.data.toString()));
      return movieResponse;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<MovieResponse?> getTrending() async {
    try {
      var dio = await dioConfig.dio();
      Response<String> response = await dio!.get("/trending/all/day");
      MovieResponse? movieResponse =
          MovieResponse.fromJson(jsonDecode(response.data.toString()));
      return movieResponse;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<MovieResponse?> getPopularMovies() async {
    try {
      var dio = await dioConfig.dio();
      Response<String> response = await dio!.get("/movie/popular");
      MovieResponse? movieResponse =
          MovieResponse.fromJson(jsonDecode(response.data.toString()));
      return movieResponse;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<MovieDetail?> getDetail(String type, String id) async {
    try {
      var dio = await dioConfig.dio();
      Response<String> response = await dio!.get("/$type/$id");
      return MovieDetail.fromJson(jsonDecode(response.data.toString()));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
