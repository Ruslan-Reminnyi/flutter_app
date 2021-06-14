import 'package:dio/dio.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_app/data/list_response.dart';

class Api {
  static const url = "https://api.themoviedb.org/3";
  static const apiKey = "c69eb1bac817427a01cf0ea4e1bedeb8";

  Dio dio = Dio();

  Future<ListResponse> getTrendingMovies(int pageNumber) async {
    final response = await dio
        .get('$url/trending/movie/day?api_key=$apiKey&page=$pageNumber');

    return ListResponse.fromJson(response.data);
  }

  Future<ListResponse> getUpcomingMovies(int pageNumber) async {
    final response =
        await dio.get('$url/movie/upcoming?api_key=$apiKey&page=$pageNumber');

    return ListResponse.fromJson(response.data);
  }

  Future<ListGenresResponse> getGenresOfMovies() async {
    final response = await dio.get('$url/genre/movie/list?api_key=$apiKey');

    return ListGenresResponse.fromJson(response.data);
  }

  Future<MovieDetailsResponse> getDetailsOfMovies(int movieId) async {
    final response = await dio.get(
        '$url/movie/$movieId?api_key=$apiKey&append_to_response=similar,credits,images');

    return MovieDetailsResponse.fromJson(response.data);
  }

  Future<ListResponse> getSimilarMovies(int movieId, int page) async {
    final response =
        await dio.get('$url/movie/$movieId/similar?api_key=$apiKey&page=$page');

    return ListResponse.fromJson(response.data);
  }

  Future<ListResponse> searchMovies(String query) async {
    final response =
        await dio.get('$url/search/movie?api_key=$apiKey&query=$query');

    return ListResponse.fromJson(response.data);
  }
}
