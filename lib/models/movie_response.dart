import 'movie.dart';

class MovieResponse {
  MovieResponse({this.results});
  List<Movie>? results;
  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      );
}
