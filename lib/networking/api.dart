import 'dart:convert';
import 'package:flutter_app/networking/response/credits_response.dart';
import 'package:flutter_app/networking/response/movie_details_response.dart';
import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/response/list_genres_response.dart';
import 'package:flutter_app/networking/response/list_photo_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';
import 'package:http/http.dart' as http;
// import 'package:movie_db/models/moviemodel.dart';
import 'package:flutter_app/data/movie_model.dart';

class Api {

  var httpClient = http.Client();

  static const url = "https://api.themoviedb.org/3";
  static const apiKey = "c69eb1bac817427a01cf0ea4e1bedeb8";

  //REVIEW there is really no need to define it as constant you use it once in oneplace
  static const trendingMovies = "trending/all/day";
  static const upcomingMovies = "movie/upcoming";
  static const genresOfMovies = "genre/movie/list";

  Future<ListResponse> getTrendingMovies(int pageNumber) async {

    final response = await http.get(Uri.parse('$url/${trendingMovies}?api_key=$apiKey&page=$pageNumber'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return ListResponse.fromJson(parsed);
    }
      return ListResponse(page: 0, totalPages: 0, totalResults: 0, movies: []);

  }

  Future<ListResponse> getUpcomingMovies(int pageNumber) async {

    final response = await http.get(Uri.parse('$url/${upcomingMovies}?api_key=$apiKey&page=$pageNumber'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return ListResponse.fromJson(parsed);
    }
    return ListResponse(page: 0, totalPages: 0, totalResults: 0, movies: []);

  }

  Future<ListGenresResponse> getGenresOfMovies() async {

    final response = await http.get(Uri.parse('$url/${genresOfMovies}?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return ListGenresResponse.fromJson(parsed);
    }
    return ListGenresResponse(genres: []);

  }

  Future<ListPhotoResponse> getPhotosOfMovies(int? movie_id) async {

    final response = await http.get(Uri.parse('$url/movie/$movie_id/images?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return ListPhotoResponse.fromJson(parsed);
    }
    return ListPhotoResponse(id: 0, backdrops: [], posters: []);

  }

  Future<MovieDetailsResponse> getDetailsOfMovies(int? movie_id) async {

    final response = await http.get(Uri.parse('$url/movie/$movie_id?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return MovieDetailsResponse.fromJson(parsed);
    }
    return MovieDetailsResponse(tagline: "");

  }

  Future<CreditsResponse> getCreditsOfMovies(int? movie_id) async {

    final response = await http.get(Uri.parse('$url/movie/$movie_id/credits?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return CreditsResponse.fromJson(parsed);
    }
    return CreditsResponse(id: 0, cast: [], crew: []);

  }

  Future<ListResponse> getSimilarMovies(int? movie_id) async {

    final response = await http.get(Uri.parse('$url/movie/$movie_id/similar?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return ListResponse.fromJson(parsed);
    }
    return ListResponse(page: 0, totalPages: 0, totalResults: 0, movies: []);

  }

}