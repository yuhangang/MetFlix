import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metflix/state/models/movie.dart';
import 'package:metflix/utils/services/movie_services.dart';

export 'package:metflix/state/models/movie.dart';

final StateNotifierProvider<MovieProvider, MovieProviderState> movieProvider =
    StateNotifierProvider<MovieProvider, MovieProviderState>((ref) {
  return MovieProvider();
});

final StateNotifierProvider<FavouriteProvider, List<Movie>> favouriteProvider =
    StateNotifierProvider<FavouriteProvider, List<Movie>>((ref) {
  return FavouriteProvider();
});

class MovieProvider extends StateNotifier<MovieProviderState> {
  MovieProvider() : super(MovieProviderState(movies: [])) {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    state = state.copyWith(status: MovieFetchingStatus.loading);
    MovieServices.getPopularVideos(page: state.pageloaded + 1).then((value) =>
        state = MovieProviderState(
            movies: [...state.movies, ...value],
            status: MovieFetchingStatus.done,
            pageloaded: state.pageloaded + 1));
  }

  Future<void> refresh() async {
    state = state.copyWith(status: MovieFetchingStatus.loading, pageLoaded: 0);
    MovieServices.getPopularVideos(page: 1).then((value) => state =
        MovieProviderState(
            movies: value, status: MovieFetchingStatus.done, pageloaded: 1));
  }
}

class MovieProviderState {
  List<Movie> movies;
  MovieFetchingStatus status;
  int pageloaded;
  MovieProviderState(
      {required this.movies,
      this.status = MovieFetchingStatus.done,
      this.pageloaded = 0});

  MovieProviderState copyWith(
      {List<Movie>? movies, MovieFetchingStatus? status, int? pageLoaded}) {
    return MovieProviderState(
        movies: movies ?? this.movies,
        status: status ?? this.status,
        pageloaded: pageLoaded ?? this.pageloaded);
  }
}

enum MovieFetchingStatus { done, loading, error, reachEnd }

class FavouriteProvider extends StateNotifier<List<Movie>> {
  FavouriteProvider() : super([]);

  void add(Movie item) => state = [...state, item];
  void remove(Movie item) {
    state.removeWhere((element) => element == item);
    state = state;
  }
}
