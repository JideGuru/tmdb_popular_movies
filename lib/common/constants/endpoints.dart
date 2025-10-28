String popularMovies(int page) {
  return '/movie/popular?language=en-US&page=$page';
}

String searchMovie(String query, int page) {
  return 'search/movie?include_adult=false&language=en-US&page=$page&query=$query';
}
