import 'package:flutter/material.dart';
import 'package:tmdb_popular_movies/features/features.dart';

class MovieListTile extends StatelessWidget {
  final MovieSummary movie;

  const MovieListTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: 'movie-poster-${movie.id}',
        child: CircleAvatar(
          backgroundImage: movie.posterPath.isNotEmpty
              ? NetworkImage(movie.fullPosterUrl)
              : null,
          child: movie.posterPath.isEmpty ? const Icon(Icons.movie) : null,
        ),
      ),
      title: Text(
        movie.title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return MovieDetailsPage(
                movieId: movie.id,
                movieTitle: movie.title,
                moviePoster: movie.fullPosterUrl,
                movieDescription: movie.overview,
                movieScore: movie.voteAverage,
              );
            },
          ),
        );
      },
    );
  }
}
