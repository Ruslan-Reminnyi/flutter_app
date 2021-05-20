import 'dart:convert';
import 'package:flutter_app/data/credits_response.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/data/list_genres_response.dart';
import 'package:flutter_app/data/list_photo_response.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:http/http.dart' as http;

class Api {
  var httpClient = http.Client();

  static const url = "https://api.themoviedb.org/3";
  static const apiKey = "c69eb1bac817427a01cf0ea4e1bedeb8";

  Future<ListResponse> getTrendingMovies() async {
    final response =
        await http.get(Uri.parse('$url/trending/movie/day?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return ListResponse.fromJson(parsed);
    }
    return ListResponse(page: 0, totalPages: 0, totalResults: 0, movies: []);
  }

  Future<ListResponse> getUpcomingMovies(int pageNumber) async {
    final response = await http
        .get(Uri.parse('$url/movie/upcoming?api_key=$apiKey&page=$pageNumber'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return ListResponse.fromJson(parsed);
    }
    return ListResponse(page: 0, totalPages: 0, totalResults: 0, movies: []);
  }

  Future<ListGenresResponse> getGenresOfMovies() async {
    final response =
        await http.get(Uri.parse('$url/genre/movie/list?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return ListGenresResponse.fromJson(parsed);
    }
    return ListGenresResponse(genres: []);
  }

  Future<ListPhotoResponse> getPhotosOfMovies(int? movieId) async {
    final response =
        await http.get(Uri.parse('$url/movie/$movieId/images?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return ListPhotoResponse.fromJson(parsed);
    }
    return ListPhotoResponse(id: 0, backdrops: [], posters: []);
  }

  Future<MovieDetailsResponse> getDetailsOfMovies(int? movieId) async {
    final response =
        await http.get(Uri.parse('$url/movie/$movieId?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return MovieDetailsResponse.fromJson(parsed);
    }
    return MovieDetailsResponse(tagline: "");
  }

  Future<CreditsResponse> getCreditsOfMovies(int? movieId) async {
    final response = await http
        .get(Uri.parse('$url/movie/$movieId/credits?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return CreditsResponse.fromJson(parsed);
    }
    return CreditsResponse(id: 0, cast: [], crew: []);
  }

  Future<ListResponse> getSimilarMovies(int? movieId) async {
    final response = await http
        .get(Uri.parse('$url/movie/$movieId/similar?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return ListResponse.fromJson(parsed);
    }
    return ListResponse(page: 0, totalPages: 0, totalResults: 0, movies: []);
  }
}
