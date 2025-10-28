import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_popular_movies/features/features.dart';

part 'search_movies_state.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  final MoviesRepository _repository;

  SearchMoviesCubit(this._repository) : super(SearchMoviesInitialState());

  Future<void> searchMovies({
    required String query,
    bool loadMore = false,
  }) async {
    if (query.trim().isEmpty) {
      emit(SearchMoviesInitialState());
      return;
    }

    try {
      if (state is SearchMoviesLoadedState && loadMore) {
        final currentState = state as SearchMoviesLoadedState;

        // Only load more if same query
        if (currentState.query != query) {
          return;
        }

        if (!currentState.hasMore || currentState.isLoadingMore) return;

        emit(currentState.copyWith(isLoadingMore: true));

        final moviesData = await _repository.searchMovies(
          query: query,
          page: currentState.currentPage + 1,
        );
        final newMovies = moviesData.movies ?? [];

        emit(
          currentState.copyWith(
            movies: [...currentState.movies, ...newMovies],
            currentPage: currentState.currentPage + 1,
            hasMore: newMovies.isNotEmpty,
            isLoadingMore: false,
          ),
        );
        return;
      }

      emit(SearchMoviesLoadingState());

      final moviesData = await _repository.searchMovies(query: query, page: 1);
      final movies = moviesData.movies ?? [];

      if (movies.isEmpty) {
        emit(SearchMoviesEmptyState(query));
      } else {
        emit(
          SearchMoviesLoadedState(
            movies: movies,
            query: query,
            currentPage: 1,
            hasMore: movies.isNotEmpty,
          ),
        );
      }
    } catch (e) {
      emit(SearchMoviesErrorState(e.toString()));
    }
  }

  void clearSearch() {
    emit(SearchMoviesInitialState());
  }
}
