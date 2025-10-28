import 'package:flutter/material.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;
  final String movieTitle;
  final String moviePoster;
  final String movieDescription;
  final double movieScore;

  const MovieDetailsPage({
    super.key,
    required this.movieId,
    required this.movieTitle,
    required this.moviePoster,
    required this.movieDescription,
    required this.movieScore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieTitle),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(height: 15),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Hero(
                tag: 'movie-poster-$movieId',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    moviePoster,
                    width: double.infinity,
                    height: 600,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                bottom: -30,
                left: 30,
                child: _ScoreBadge(score: movieScore),
              ),
            ],
          ),
          SizedBox(height: 50),

          Text(movieDescription, style: TextStyle(fontSize: 16)),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  final double score;

  const _ScoreBadge({required this.score});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - value)), // slight upward slide
            child: child,
          ),
        );
      },
      // child = the static part (built once)
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(5),
        child: Stack(
          children: [
            Positioned.fill(
              child: CircularProgressIndicator(
                value: (score / 10).clamp(0.0, 1.0),
                color: Colors.green.shade600,
              ),
            ),

            Center(
              child: Text(
                '${(score * 10).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
