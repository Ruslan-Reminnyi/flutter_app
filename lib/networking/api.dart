import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/data/favorite_request.dart';
import 'package:flutter_app/data/favorite_response.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/api_token.dart';
import 'package:flutter_app/data/session_id.dart';

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

  Future<ListResponse> searchMovies(String query, int page) async {
    await Future.delayed(Duration(seconds: 5));
    final response = await dio
        .get('$url/search/movie?api_key=$apiKey&query=$query&page=$page');

    return ListResponse.fromJson(response.data);
  }

  Future<ApiToken> getRequestToken() async {
    final response =
        await dio.get('$url/authentication/token/new?api_key=$apiKey');

    return ApiToken.fromJson(response.data);
  }

  Future<SessionId> getSessionId(String token) async {
    ApiToken apiToken = ApiToken(token: token);
    final response = await dio.post(
        '$url/authentication/session/new?api_key=$apiKey',
        data: jsonEncode(apiToken));

    return SessionId.fromJson(response.data);
  }

  Future<ListResponse> getFavoriteMovies(
      String sessionId, int pageNumber) async {
    final response = await dio.get(
        '$url/account/favorite/movies?api_key=$apiKey&session_id=$sessionId&page=$pageNumber');
    print('statusCode ${response.statusCode}');
    return ListResponse.fromJson(response.data);
  }

  Future<FavoriteResponse> markMovieAsFavorite(
      String sessionId, FavoriteRequest request) async {

    final response = await dio.post(
        '$url/account/{account_id}/favorite?api_key=$apiKey&session_id=$sessionId',
        data: jsonEncode(request),
        options: Options(contentType: 'application/json;charset=utf-8'));

    print('markMovieAsFavorite ${response.statusCode}');
    print('markMovieAsFavorite ${response.statusMessage}');

    return FavoriteResponse.fromJson(response.data);
  }
}
