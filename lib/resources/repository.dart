import 'package:elwarshatask/Model/upComing_model.dart';
import 'package:elwarshatask/constant/movie_type.dart';

import 'apiProvider.dart';

class Repository {
  // int id;
  final apiProvider = ApiProvider();
  Future<MoviesModel> fetchUpcomingMovies() =>
      apiProvider.fetchMoviesType(MovieType.UPCOMING);
  Future<MoviesModel> fetchTopRatedMovies() =>
      apiProvider.fetchMoviesType(MovieType.TOP_RATED);
  Future<MoviesModel> fetchPopularMovies() =>
      apiProvider.fetchMoviesType(MovieType.POPULAR);
      
  Future<MoviesModel> fetchTrendingWeek() => apiProvider.fetchTrendingWeek();
  Future<MoviesModel> fetchPopularTv() => apiProvider.fetchPopularTv();
  // Future<Genre> fetchMoviesGener() =>
  //     apiProvider.fetchGener(MovieAndTVGenre.Movie);
  // Future<Genre> fetchTvGener() => apiProvider.fetchGener(MovieAndTVGenre.Tv);
  Future<MoviesModel> fetchMovieDetails(int id) => apiProvider.fetchMovieDetails(id);

  
}
