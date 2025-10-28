import 'package:dio/dio.dart';
import 'package:tmdb_popular_movies/common/common.dart';
import 'package:tmdb_popular_movies/features/features.dart';

typedef PopularMoviesData = ({
  List<MovieSummary>? movies,
  NetworkRequestError? error,
});

typedef SearchMoviesData = ({
  List<MovieSummary>? movies,
  NetworkRequestError? error,
});

typedef MovieDetailsData = ({MovieDetail? movie, NetworkRequestError? error});

class MoviesRepository {
  final Dio _restClient;

  const MoviesRepository({required Dio restClient}) : _restClient = restClient;

  Future<PopularMoviesData> getPopularMovies({int page = 1}) async {
    try {
      final response = await _restClient.get(popularMovies(page));
      final data = response.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;

      final movies = results
          .map((movieJson) => MovieSummary.fromJson(movieJson))
          .toList();

      return (movies: movies, error: null);
    } catch (e) {
      return (movies: null, error: NetworkRequestError(message: e.toString()));
    }
  }

  Future<SearchMoviesData> searchMovies({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await _restClient.get(searchMovie(query, page));
      final data = response.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;

      final movies = results
          .map((movieJson) => MovieSummary.fromJson(movieJson))
          .toList();

      return (movies: movies, error: null);
    } catch (e) {
      return (movies: null, error: NetworkRequestError(message: e.toString()));
    }
  }
}
