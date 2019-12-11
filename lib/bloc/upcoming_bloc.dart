import 'package:elwarshatask/Model/upComing_model.dart';
import 'package:elwarshatask/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _repository = Repository();

  //StreamController
  final _upComingMovieFetcher = PublishSubject<MoviesModel>();
  // final _comingMovieFetcher = Broadcasts<MoviesModel>();

  final _popualrMovieFetcher = PublishSubject<MoviesModel>();
  final _topRatedMoiveFetcher = PublishSubject<MoviesModel>();
  final _trendingFetcher = PublishSubject<MoviesModel>();
  final _popularTvFetcher = PublishSubject<MoviesModel>();
  final _movieGenerFtecher = PublishSubject<MoviesModel>();

//getter for stream
  Observable<MoviesModel> get allUpComing => _upComingMovieFetcher.stream;
  Observable<MoviesModel> get allPopular => _popualrMovieFetcher.stream;
  Observable<MoviesModel> get allTopRated => _topRatedMoiveFetcher.stream;
  Observable<MoviesModel> get trendingWeek => _trendingFetcher.stream;
  Observable<MoviesModel> get popularTv => _popularTvFetcher.stream;
  Observable<MoviesModel> get movieGener => _movieGenerFtecher.stream;

  // async Methods
  fetchAllUpcoming() async {
    MoviesModel upComingModel = await _repository.fetchUpcomingMovies();
    _upComingMovieFetcher.sink.add(upComingModel);
  }

  fetchAllPopular() async {
    MoviesModel popularModel = await _repository.fetchPopularMovies();
    _popualrMovieFetcher.sink.add(popularModel);
  }

  fetchAllTopRated() async {
    MoviesModel topRatedModel = await _repository.fetchTopRatedMovies();
    _topRatedMoiveFetcher.sink.add(topRatedModel);
  }

  fetchTrendingWeek() async {
    MoviesModel trendingModel = await _repository.fetchTrendingWeek();
    _trendingFetcher.sink.add(trendingModel);
  }

  fetchPopularTv() async {
    MoviesModel popularModel = await _repository.fetchPopularTv();
    _popularTvFetcher.sink.add(popularModel);
  }

  fetchMovieGener(int id) async {
    MoviesModel movieGenerModel = await _repository.fetchMovieDetails(id);
    _movieGenerFtecher.sink.add(movieGenerModel);
  }

//close controller
  dispose() {
    _upComingMovieFetcher.close();
    _popualrMovieFetcher.close();
    _topRatedMoiveFetcher.close();
    _trendingFetcher.close();
    _popularTvFetcher.close();
    _movieGenerFtecher.close();
  }
}

final bloc = HomeBloc();
