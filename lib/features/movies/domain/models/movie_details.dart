class MovieDetail {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String originalLanguage;
  final String releaseDate;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final bool adult;
  final bool video;
  final int? budget;
  final int? revenue;
  final int? runtime;
  final String status;
  final String tagline;
  final String homepage;
  final String imdbId;
  final List<Genre> genres;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<SpokenLanguage> spokenLanguages;

  MovieDetail({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.originalLanguage,
    required this.releaseDate,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.adult,
    required this.video,
    this.budget,
    this.revenue,
    this.runtime,
    required this.status,
    required this.tagline,
    required this.homepage,
    required this.imdbId,
    required this.genres,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      releaseDate: json['release_date'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      adult: json['adult'] ?? false,
      video: json['video'] ?? false,
      budget: json['budget'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      homepage: json['homepage'] ?? '',
      imdbId: json['imdb_id'] ?? '',
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((e) => Genre.fromJson(e))
              .toList() ??
          [],
      productionCompanies:
          (json['production_companies'] as List<dynamic>?)
              ?.map((e) => ProductionCompany.fromJson(e))
              .toList() ??
          [],
      productionCountries:
          (json['production_countries'] as List<dynamic>?)
              ?.map((e) => ProductionCountry.fromJson(e))
              .toList() ??
          [],
      spokenLanguages:
          (json['spoken_languages'] as List<dynamic>?)
              ?.map((e) => SpokenLanguage.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'original_language': originalLanguage,
      'release_date': releaseDate,
      'popularity': popularity,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'adult': adult,
      'video': video,
      'budget': budget,
      'revenue': revenue,
      'runtime': runtime,
      'status': status,
      'tagline': tagline,
      'homepage': homepage,
      'imdb_id': imdbId,
      'genres': genres.map((e) => e.toJson()).toList(),
      'production_companies': productionCompanies
          .map((e) => e.toJson())
          .toList(),
      'production_countries': productionCountries
          .map((e) => e.toJson())
          .toList(),
      'spoken_languages': spokenLanguages.map((e) => e.toJson()).toList(),
    };
  }

  String get fullPosterUrl => 'https://image.tmdb.org/t/p/w500$posterPath';
  String get fullBackdropUrl => 'https://image.tmdb.org/t/p/w780$backdropPath';
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json['id'] ?? 0, name: json['name'] ?? '');

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class ProductionCompany {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  ProductionCompany({
    required this.id,
    required this.name,
    this.logoPath,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        logoPath: json['logo_path'],
        originCountry: json['origin_country'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo_path': logoPath,
    'origin_country': originCountry,
  };
}

class ProductionCountry {
  final String iso3166_1;
  final String name;

  ProductionCountry({required this.iso3166_1, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso3166_1: json['iso_3166_1'] ?? '',
        name: json['name'] ?? '',
      );

  Map<String, dynamic> toJson() => {'iso_3166_1': iso3166_1, 'name': name};
}

class SpokenLanguage {
  final String iso639_1;
  final String englishName;
  final String name;

  SpokenLanguage({
    required this.iso639_1,
    required this.englishName,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    iso639_1: json['iso_639_1'] ?? '',
    englishName: json['english_name'] ?? '',
    name: json['name'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'iso_639_1': iso639_1,
    'english_name': englishName,
    'name': name,
  };
}
