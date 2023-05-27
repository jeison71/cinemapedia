import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

//
class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

//se transforma el stateFullwidge en un ConsumerStateFulWidget
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

//Cambiamos el State por ConsumerState
class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProviders.notifier).loadNextPage();
    ref.read(popularMoviesProviders.notifier).loadNextPage();
    ref.read(topRatedMoviesProviders.notifier).loadNextPage();
    ref.read(upcomingMoviesProviders.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    //
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProviders);
    final popularMovies = ref.watch(popularMoviesProviders);
    final upcomingMovies = ref.watch(upcomingMoviesProviders);
    final topRatedMovies = ref.watch(topRatedMoviesProviders);
    //
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        //
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                // const CustomAppbar(),
                MoviesSlideShow(movies: slideShowMovies),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProviders.notifier).loadNextPage();
                  },
                ),
                //
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Popular',
                  subTitle: 'de siempre',
                  loadNextPage: () {
                    ref.read(popularMoviesProviders.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  subTitle: 'En um mes',
                  loadNextPage: () {
                    ref.read(upcomingMoviesProviders.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor Calificadas',
                  subTitle: 'Por los Cineastas',
                  loadNextPage: () {
                    ref.read(topRatedMoviesProviders.notifier).loadNextPage();
                  },
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        )),
      ],
    );
  }
}
