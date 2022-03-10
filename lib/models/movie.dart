class Movie {
  Movie({
    this.id,
    this.posterPath,
    this.title,
    this.type,
  });
  int? id;
  String? posterPath;
  String? title;
  String? type;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        posterPath: json["poster_path"] != null
            ? "https://image.tmdb.org/t/p/w500/" + json["poster_path"]
            : "",
        title: json["media_type"]!=null?json["media_type"]=="movie"?json["title"]:json["name"]:json["title"]??json["name"],
        type: json["title"]!=null?"movie":"tv",
      );
}



