import 'package:movie/models/movie_genre.dart';

class MovieDetail{
  
  final bool adult;
  final String backdropPath;
  final List<MovieGenre> genres;
  final int id;
  final String overview;
  final double popularity;
  final String posterPath;
  final String title;
  final double voteAverage;
  final int voteCount;
  final int runtime;

  const MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genres: (json['genres'] as List<dynamic>).map((e) => MovieGenre.fromJson(e)).toList(),
      id: json['id'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      title: json['title'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      runtime: json['runtime'],
    );
  }
}
