import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProviders =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});
//
final popularMoviesProviders =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPopular;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});
//
final upcomingMoviesProviders =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});
//
final topRatedMoviesProviders =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});
//
typedef MovieCallback = Future<List<Movie>> Function({int page});
//

class MoviesNotifier extends StateNotifier<List<Movie>> {
  //
  int currentPage = 0;
  bool isloading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isloading) return;
    isloading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    await Future.delayed(const Duration(milliseconds: 300));
    state = [...state, ...movies];
    isloading = false;
  }
}
