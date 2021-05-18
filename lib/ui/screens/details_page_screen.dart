import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/movie_state.dart';
import 'package:flutter_app/bloc/photo_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/data/product_companies_model.dart';
import 'package:flutter_app/networking/response/credits_response.dart';
import 'package:flutter_app/networking/response/list_photo_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';
import 'package:flutter_app/networking/response/movie_details_response.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key, required this.movieModel, required this.genres, required this.photos, required this.movieDetailsResponse, required this.creditsResponse, required this.listResponseSimilarMovies}) : super(key: key);

  final MovieModel? movieModel;
  final String? genres;
  final ListPhotoResponse? photos;
  final MovieDetailsResponse movieDetailsResponse;
  final CreditsResponse creditsResponse;
  final ListResponse listResponseSimilarMovies;
  final LinearGradient linearGradient = LinearGradient(
    colors: <Color>[
      Colors.white,
      Colors.black
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
       backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'New Movie',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            decoration: TextDecoration.none,
          ),
        ),

      ),
      body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 430,
                child: Image.network(
                  "https://image.tmdb.org/t/p/original${movieModel?.backdrop_path}",
                  fit: BoxFit.fitHeight,
                ),
              ),
                Container(
                  height: 425,
                  width: 400,
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                      stops: [
                      0.0,
                      1.0
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 180.0, 0.0, 0.0),
                child: Container(
                  height: 140,
                  child: Row(
                    children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/original${movieModel?.poster_path}",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                                  child:
                                  Text(
                                      movieModel?.original_title != null
                                          ? '${movieModel?.original_title}'
                                          : '${movieModel?.original_name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                ),
                              SizedBox(
                                height: 15,
                              ),
                              _movieInfo(),
                            ],
                        ),
                          ),
                      Container(
                        width: 70,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 60.0, 20.0, 0.0),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/original${movieDetailsResponse?.production_companies?[0].logo_path}",
                            // fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, top: 348),
                  width: 350,
                  child: ShaderMask(
                    shaderCallback: (_) => linearGradient.createShader(
                      Rect.fromLTWH(0, 0, 0, 70),
                    ),
                    child: Text(
                      '${movieModel?.overview}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                    ),
                ),
                  ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 420),
                child: Text(
                  'Photos',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 450),
                height: 155,
                width: 375,
                child: _listWidgetsPhotos(),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 635),
                child: Text(
                  'Cast',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 670),
                height: 90,
                width: 375,
                child: _listWidgetsCredits(),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 790),
                child: Text(
                  'Similar Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 825),
                height: 275,
                width: 375,
                child: _similarMovies(context),
              ),
            ],
          ),
        ),
    );
  }

  Widget _movieInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              RatingBarIndicator(
                rating: movieModel?.rating ?? 0.0,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 10,
                itemSize: 8.0,
                unratedColor: Colors.amber.withAlpha(50),
                direction: Axis.horizontal,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "${movieModel?.rating}/10 IMDb",
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 11.0),
          child: Row(
            children: [
              Text(
                durationToHours(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  decoration: TextDecoration.none,
                ),
              ),
              Expanded(
                child: Text(
                  "$genres",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            getNameOfDirector() ?? "Director: ",
            style: TextStyle(
              fontSize: 9,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            getNameOfWriter() ?? "Writer: ",
            style: TextStyle(
              fontSize: 9,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );

  }

  Widget _listWidgetsPhotos() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: photos?.backdrops?.length,
      itemBuilder: (ctx, index) {
        return Container(
            width: 280,
            child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
        "https://image.tmdb.org/t/p/original${photos?.backdrops?[index].path}",
        fit: BoxFit.contain,
        ),
          ),
            ),
        );
      },
    );
  }

  Widget _listWidgetsCredits() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: creditsResponse?.cast?.length,
      itemBuilder: (ctx, index) {
        return Container(
          child: _imageWidget(index),
        );
      },
    );
  }

  Widget _imageWidget(int index) {

    if(creditsResponse?.cast?[index].path != null) {
      return Container(
        width: 90,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              "https://image.tmdb.org/t/p/original${creditsResponse?.cast?[index].path}",
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }

  }

  Widget _similarMovies(BuildContext context) {

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listResponseSimilarMovies?.movies?.length,
      itemBuilder: (ctx, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/original${listResponseSimilarMovies?.movies?[index].poster_path}",
                    // fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 150,
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  listResponseSimilarMovies.movies?[index].original_title ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

  }

  Widget _nameOfSimilarMovies(BuildContext context) {

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listResponseSimilarMovies?.movies?.length,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            listResponseSimilarMovies.movies?[index].original_title ?? '',
            maxLines: 2,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        );
      },
    );

  }

  String durationToHours() {

    int? runtime = movieDetailsResponse.runtime;
    print(runtime);
    int? hours = runtime! ~/ 60;

    int? minutes = runtime % 60;

    return minutes != 0 ? "${hours}h ${minutes}m | " : "${hours}h | ";

  }

  String? getNameOfDirector() {
    var name = creditsResponse?.crew?.firstWhere((element) => element.job == "Director").name;
    return "Director: ${name}";
  }

  String? getNameOfWriter() {
    var name = creditsResponse?.crew?.firstWhere((element) => element.department == "Writing").name;
    return "Writer: ${name}";
  }

}
