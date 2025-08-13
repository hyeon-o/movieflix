import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie/models/movie_detail.dart';
import 'package:movie/models/paginated_response.dart';
import 'package:movie/models/movie.dart';

class ApiService {
  static const String baseUrl = 'https://movies-api.nomadcoders.workers.dev';
  
  // 캐시를 위한 static 변수들
  static PaginatedResponse<Movie>? _popularMoviesCache;
  static PaginatedResponse<Movie>? _nowPlayingMoviesCache;
  static PaginatedResponse<Movie>? _comingSoonMoviesCache;
  static final Map<int, MovieDetail> _movieDetailCache = {};

  static Future<PaginatedResponse<Movie>> getPopularMovies() async {
    // 캐시된 데이터가 있으면 반환
    if (_popularMoviesCache != null) {
      return _popularMoviesCache!;
    }
    
    final uri = Uri.parse('$baseUrl/popular');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body);
      _popularMoviesCache = PaginatedResponse<Movie>.fromJson(movies, Movie.fromJson);
      return _popularMoviesCache!;
    }
    throw Error();
  }

  static Future<PaginatedResponse<Movie>> getNowPlayingMovies() async {
    // 캐시된 데이터가 있으면 반환
    if (_nowPlayingMoviesCache != null) {
      return _nowPlayingMoviesCache!;
    }
    
    final uri = Uri.parse('$baseUrl/now-playing');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body);
      _nowPlayingMoviesCache = PaginatedResponse<Movie>.fromJson(movies, Movie.fromJson);
      return _nowPlayingMoviesCache!;
    }
    throw Error();
  }

  static Future<PaginatedResponse<Movie>> getComingSoonMovies() async {
    // 캐시된 데이터가 있으면 반환
    if (_comingSoonMoviesCache != null) {
      return _comingSoonMoviesCache!;
    }
    
    final uri = Uri.parse('$baseUrl/coming-soon');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body);
      _comingSoonMoviesCache = PaginatedResponse<Movie>.fromJson(movies, Movie.fromJson);
      return _comingSoonMoviesCache!;
    }
    throw Error();
  }

  static Future<MovieDetail> getMovieDetail(int id) async {
    // 캐시된 데이터가 있으면 반환
    if (_movieDetailCache.containsKey(id)) {
      return _movieDetailCache[id]!;
    }
    
    final uri = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      final movieDetail = MovieDetail.fromJson(movie);
      _movieDetailCache[id] = movieDetail;
      return movieDetail;
    }
    throw Error();
  }
  
  // 캐시 초기화 메서드 (필요시 사용)
  static void clearCache() {
    _popularMoviesCache = null;
    _nowPlayingMoviesCache = null;
    _comingSoonMoviesCache = null;
    _movieDetailCache.clear();
  }
}
