import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_popular_movies/features/features.dart';

import '../../../../common/common.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PopularMoviesCubit _popularMoviesCubit;
  late final SearchMoviesCubit _searchMoviesCubit;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    final repository = MoviesRepository(restClient: AppDio.getInstance());

    _popularMoviesCubit = PopularMoviesCubit(repository)..fetchPopularMovies();

    _searchMoviesCubit = SearchMoviesCubit(repository);

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isSearching && _searchMoviesCubit.state is! SearchMoviesInitialState) {
      final state = _searchMoviesCubit.state;
      if (state is SearchMoviesLoadedState &&
          state.hasMore &&
          !state.isLoadingMore &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
        _searchMoviesCubit.searchMovies(query: state.query, loadMore: true);
      }
    } else {
      final state = _popularMoviesCubit.state;
      if (state is PopularMoviesLoadedState &&
          state.hasMore &&
          !state.isLoadingMore &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
        _popularMoviesCubit.fetchPopularMovies(loadMore: true);
      }
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _searchMoviesCubit.clearSearch();
        _popularMoviesCubit.fetchPopularMovies();
      }
    });
  }

  void _performSearch(String query) {
    if (query.trim().isNotEmpty) {
      _searchMoviesCubit.searchMovies(query: query);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _popularMoviesCubit.close();
    _searchMoviesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: Theme.of(context).appBarTheme.titleTextStyle,
                decoration: const InputDecoration(
                  hintText: 'Search movies...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  if (value.trim().isEmpty) {
                    _searchMoviesCubit.clearSearch();
                  } else {
                    _performSearch(value);
                  }
                },
              )
            : const Text('Movie viewer'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _toggleSearch,
            icon: Icon(_isSearching ? Icons.close : Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
        bloc: _searchMoviesCubit,
        builder: (context, searchState) {
          if (_isSearching && searchState is! SearchMoviesInitialState) {
            return _buildSearchBody();
          }
          return _buildPopularMoviesBody();
        },
      ),
    );
  }

  Widget _buildPopularMoviesBody() {
    return BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
      bloc: _popularMoviesCubit,
      builder: (context, state) {
        if (state is PopularMoviesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PopularMoviesErrorState) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is PopularMoviesLoadedState) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return const Center(child: Text('No movies found.'));
          }

          return _buildMoviesList(
            movies: movies,
            isLoadingMore: state.isLoadingMore,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSearchBody() {
    return BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
      bloc: _searchMoviesCubit,
      builder: (context, state) {
        if (state is SearchMoviesInitialState) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Search for movies',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        if (state is SearchMoviesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SearchMoviesErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${state.message}'),
              ],
            ),
          );
        }

        if (state is SearchMoviesEmptyState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search_off, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                Text('No results found for "${state.query}"'),
              ],
            ),
          );
        }

        if (state is SearchMoviesLoadedState) {
          return _buildMoviesList(
            movies: state.movies,
            isLoadingMore: state.isLoadingMore,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMoviesList({
    required List<MovieSummary> movies,
    required bool isLoadingMore,
  }) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: movies.length + (isLoadingMore ? 1 : 0),
      separatorBuilder: (context, index) => const Divider(thickness: 1.5),
      itemBuilder: (context, index) {
        if (index == movies.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final movie = movies[index];
        return MovieListTile(movie: movie);
      },
    );
  }
}
