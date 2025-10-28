import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_popular_movies/features/features.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final MoviesRepository _repository;

  PopularMoviesCubit(this._repository) : super(PopularMoviesInitialState());

  Future<void> fetchPopularMovies({bool loadMore = false}) async {
    try {
      if (state is PopularMoviesLoadedState && loadMore) {
        final currentState = state as PopularMoviesLoadedState;
        if (!currentState.hasMore || currentState.isLoadingMore) return;

        emit(currentState.copyWith(isLoadingMore: true));

        final moviesData = await _repository.getPopularMovies(
          page: currentState.currentPage + 1,
        );

        if (moviesData.error != null) {
          return;
        }

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

      emit(PopularMoviesLoadingState());

      final moviesData = await _repository.getPopularMovies(page: 1);

      if (moviesData.error != null) {
        emit(PopularMoviesErrorState(moviesData.error!.message));

        return;
      }

      final movies = moviesData.movies ?? [];

      emit(
        PopularMoviesLoadedState(
          movies: movies,
          currentPage: 1,
          hasMore: movies.isNotEmpty,
        ),
      );
    } catch (e) {
      emit(PopularMoviesErrorState(e.toString()));
    }
  }
}
