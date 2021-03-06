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
        releaseDate: DateTime.parse(json["release_date"]??json["first_air_date"]),
        title: json["title"]??json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}