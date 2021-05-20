import 'package:flutter/material.dart';
import 'package:flutter_app/data/product_companies_model.dart';
import 'package:flutter_app/networking/response/credits_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';
import 'package:flutter_app/networking/response/movie_details_response.dart';
import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/data/photo_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/networking/response/list_genres_response.dart';
import 'package:flutter_app/networking/response/list_photo_response.dart';
import 'package:flutter_app/ui/screens/another_screen.dart';
import 'package:flutter_app/ui/screens/details_page_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieContainer extends StatelessWidget {

  final int number;
  final MovieModel? movieModel;
  final String? genres;
  final String? tagline;
  final ListPhotoResponse? photos;
  final MovieDetailsResponse movieDetailsResponse;
  final CreditsResponse creditsResponse;
  final ListResponse listResponseSimilarMovies;
  // final List<String?> listGenresOfSimilarMovies;

  MovieContainer({
    Key? key,
    required this.number,
    required this.movieModel,
    required this.genres,
    required this.tagline,
    required this.photos,
    required this.movieDetailsResponse,
    required this.creditsResponse,
    required this.listResponseSimilarMovies,
    // required this.listGenresOfSimilarMovies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () {

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Details Screen ${movieModel?.genres}"),
          ));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => DetailsScreen(
                movieModel: movieModel,
                genres: genres,
                photos: photos,
                movieDetailsResponse: movieDetailsResponse,
                creditsResponse: creditsResponse,
                listResponseSimilarMovies: listResponseSimilarMovies,
                // listGenresOfSimilarMovies: listGenresOfSimilarMovies,
              ),
              // builder: (ctx) => AnotherScreen(photos: photos,),
            ),
          );
        },
        child: Container(
            width: 335,
            margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      number < 10 ? '0${number}' : '${number}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      movieModel?.originalTitle != null
                          ? '${movieModel?.originalTitle}'
                          : '${movieModel?.originalName}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/original${movieModel?.backdropPath}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    width: 325,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                              style: TextStyle(fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$tagline",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$genres",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ])));
  }
}
