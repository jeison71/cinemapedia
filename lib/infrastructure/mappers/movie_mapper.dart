//la mision  es leer diferentes modelos y crear mi entidad

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviesdb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDb moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://ih1.redbubble.net/image.533910704.5853/poster,504x498,f8f8f8-pad,600x600,f8f8f8.u3.jpg',
        genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
            : 'no-poster',
        releaseDate: moviedb.releaseDate,
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );
}
