part of 'search_movies_cubit.dart';

sealed class SearchMoviesState {}

final class SearchMoviesInitialState extends SearchMoviesState {}

final class SearchMoviesLoadingState extends SearchMoviesState {}

final class SearchMoviesLoadedState extends SearchMoviesState {
  final List<MovieSummary> movies;
  final String query;
  final bool hasMore;
  final int currentPage;
  final bool isLoadingMore;

  SearchMoviesLoadedState({
    required this.movies,
    required this.query,
    this.hasMore = true,
    this.currentPage = 1,
    this.isLoadingMore = false,
  });

  SearchMoviesLoadedState copyWith({
    List<MovieSummary>? movies,
    String? query,
    bool? hasMore,
    int? currentPage,
    bool? isLoadingMore,
  }) {
    return SearchMoviesLoadedState(
      movies: movies ?? this.movies,
      query: query ?? this.query,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class SearchMoviesEmptyState extends SearchMoviesState {
  final String query;

  SearchMoviesEmptyState(this.query);
}

final class SearchMoviesErrorState extends SearchMoviesState {
  final String message;

  SearchMoviesErrorState(this.message);
}
