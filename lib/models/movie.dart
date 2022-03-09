// class Movie {
//   final String title;
//   final String poster;

//   Movie({ this.title, this.poster });

//   Movie.fromJson(Map<String, dynamic> json)
//     : title = json['Title'],
//       poster = json['Poster'];

//   Map<String, dynamic> toJson() => {
//     'Title': title,
//     'Poster': poster
//   };
// }

class Movie {
  Movie({
    this.id,
    this.posterPath,
    this.title,
  });
  int? id;
  String? posterPath;
  String? title;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        posterPath: json["poster_path"] != null
            ? "https://image.tmdb.org/t/p/w500/" + json["poster_path"]
            : "",
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster_path": posterPath,
        "title": title,
      };
}

class MovieDetail {
  MovieDetail({
    this.id,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  });
  int? id;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  double? voteAverage;
  int? voteCount;

  factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"] == null
            ? ""
            : "https://image.tmdb.org/t/p/w500/" + json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
