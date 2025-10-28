part of 'popular_movies_cubit.dart';

sealed class PopularMoviesState {}

final class PopularMoviesInitialState extends PopularMoviesState {}

final class PopularMoviesLoadingState extends PopularMoviesState {}

final class PopularMoviesLoadedState extends PopularMoviesState {
  final List<MovieSummary> movies;
  final bool hasMore;
  final int currentPage;
  final bool isLoadingMore;

  PopularMoviesLoadedState({
    required this.movies,
    this.hasMore = true,
    this.currentPage = 1,
    this.isLoadingMore = false,
  });

  PopularMoviesLoadedState copyWith({
    List<MovieSummary>? movies,
    bool? hasMore,
    int? currentPage,
    bool? isLoadingMore,
  }) {
    return PopularMoviesLoadedState(
      movies: movies ?? this.movies,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class PopularMoviesErrorState extends PopularMoviesState {
  final String message;

  PopularMoviesErrorState(this.message);
}
