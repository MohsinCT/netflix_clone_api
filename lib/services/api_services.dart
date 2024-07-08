import 'dart:convert';
import 'dart:developer';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/movie_detailed_model.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/models/movie_recommendation_model.dart';
import 'package:netflix_clone/models/now_playing_model.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/models/tv_series_model.dart';
import 'package:netflix_clone/models/tv_show_model.dart';

var key = "api_key=$apiKey";
late String endPoint;

class ApiServices {

  // NowPlayingMovies

  Future<NowPlayingModel> getNowPlayingMovies() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint?$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('Success NowPlayingMovies');
      return NowPlayingModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load NowPlayingMovies');
    }
  }

  // UpcomingMovies

  Future<UpcomingMovieModel> getUpcomingMovies() async {
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint?$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('Success UpcomingMovies');
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load UpcomingMovies');
    }
  }

  // TvSeriesMovies

  Future<TvSeriesModel> getTvSeriesMovies() async {
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint?$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('Success TvSeriesMovies');
      return TvSeriesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load TvSeriesMovies');
    }
  }
Future<SearchModel> getSearchMovies(String searchText)async{
  endPoint ="search/movie?query=$searchText";
  final url = "$baseUrl$endPoint?";
  print(url);
  final response = await http.get(Uri.parse(url),headers:{
          'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNGQxZDBiNjAxN2U0MGQ1NWMyZjlhMjVlYWRiNmVmYiIsIm5iZiI6MTcxOTc1OTYyNC41NDQxNzMsInN1YiI6IjY2NzNjYzhjM2RiOGFlZjM1ODhmMWEyOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.D2sVgq7Ywsz7e3bJk8q0CSpQNm5gF0Xygjo68HM1iXM'
  } );
  if(response.statusCode == 200){
    log('Success SearchMovies');
    return SearchModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failed to load SearchMovies');
  }
}
 Future<MovieRecommendationModel> getPopularMovies()async{
  endPoint ="movie/popular";
  final url = "$baseUrl$endPoint?$key";
  final response = await http.get(Uri.parse(url));
  if(response.statusCode == 200){
    log('success PopularMovies');
    return MovieRecommendationModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failed to load PopularMovies');
  }
 }
  Future<MovieDetailedModel> getMovieDetails(int movieId) async {
    endPoint = "movie/$movieId";
    final url = "$baseUrl$endPoint?$key";
    print(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('Success MovieDetails');
      return MovieDetailedModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load MovieDetails');
    }
  }
  Future<TvShowModel> getTvShows()async{
    endPoint = "discover/tv";
    final url ="$baseUrl$endPoint?$key";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      log('Success tvshows');
      return TvShowModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load TvShows');
    }
  }
  Future<MovieRecommendationModel> getMovieRecommendation(int movieId)async{
    endPoint = 'movie/$movieId/recommendations';
    final url = "$baseUrl$endPoint?$key";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      log('Success recommendations');
      return MovieRecommendationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load recommendation');
    }

  }
 
}
