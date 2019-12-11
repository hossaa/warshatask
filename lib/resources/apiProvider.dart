import 'dart:convert';

import 'package:elwarshatask/Model/upComing_model.dart';
import 'package:http/http.dart' show Client;

class ApiProvider {
  Client client = Client();
  final _apiKey = '351b13cf17d83ad0c0eb3782e4feef03';

  Future<MoviesModel> fetchMoviesType(String type) async {
    final String _baseUrl =
        "https://api.themoviedb.org/3/movie/$type?api_key=$_apiKey";

    final response = await client.get(_baseUrl);
    if (response.statusCode == 200) {
      return MoviesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Faild to load");
    }
  }

  Future<MoviesModel> fetchTrendingWeek() async {
    final String url =
        "https://api.themoviedb.org/3/trending/all/week?api_key=$_apiKey";

    final response = await client.get(url);
    if (response.statusCode == 200) {
      return MoviesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Faild to load");
    }
  }

  Future<MoviesModel> fetchPopularTv() async {
    final String url =
        "https://api.themoviedb.org/3/tv/popular?api_key=$_apiKey";

    final response = await client.get(url);
    if (response.statusCode == 200) {
      return MoviesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Faild to load");
    }
  }

  // Future<Genre> fetchGener(String type) async {
  //   final String url =
  //       "https://api.themoviedb.org/3/genre/$type/list?api_key=$_apiKey";
  //   final response = await client.get(url);
  //   if (response.statusCode == 200) {
  //     return Genre(json.decode(response.body));
  //   } else {
  //     throw Exception("Faild to load");
  //   }
  // }

  Future<MoviesModel> fetchMovieDetails(int id) async {
    final String url =
        "https://api.themoviedb.org/3/movie/$id?api_key=$_apiKey";
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return MoviesModel.detailJson(json.decode(response.body));
    } else {
      throw Exception("Faild to load");
    }
  }


}

//  https://api.themoviedb.org/3/movie/540901/credits?api_key=351b13cf17d83ad0c0eb3782e4feef03