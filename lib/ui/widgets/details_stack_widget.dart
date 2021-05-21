import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/credits_response.dart';
import 'package:flutter_app/data/list_photo_response.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/ui/widgets/details_category_name_widget.dart';
import 'package:flutter_app/ui/widgets/details_info_widget.dart';
import 'package:flutter_app/ui/widgets/list_credits_widget.dart';
import 'package:flutter_app/ui/widgets/list_photos_widget.dart';
import 'package:flutter_app/ui/widgets/similar_movies_widget.dart';

class DetailsStackWidget extends StatelessWidget {
  DetailsStackWidget(
      {required this.context,
      this.photos,
      required this.movieDetailsResponse,
      required this.creditsResponse,
      required this.listResponseSimilarMovies,
      required this.genresOfSimilarMovie});

  final BuildContext context;
  final ListPhotoResponse? photos;
  final MovieDetailsResponse movieDetailsResponse;
  final CreditsResponse creditsResponse;
  final ListResponse listResponseSimilarMovies;
  final List<String?> genresOfSimilarMovie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 430,
          child: Image.network(
            //REVIEW should have all cases of image link construction as function not placed all over the place apply DRY principle
            "https://image.tmdb.org/t/p/original${movieDetailsResponse.backdropPath}",
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
          height: 425,
          //REVIEW magic numbers
          width: 400,
          //REVIEW magic numbers
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black,
              ],
              stops: [0.0, 1.0],
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
                    "https://image.tmdb.org/t/p/original${movieDetailsResponse.posterPath}",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(
                  child: DetailsInfoWidget(
                    movieDetailsResponse: movieDetailsResponse,
                    creditsResponse: creditsResponse,
                  ),
                ),
                Container(
                  width: 70,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 60.0, 20.0, 0.0),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original${movieDetailsResponse.productionCompanies?[0].logoPath}",
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
            shaderCallback: (_) => kLinearGradient.createShader(
              Rect.fromLTWH(0, 0, 0, 70),
            ),
            child: Text(
              '${movieDetailsResponse.overview}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
        DetailsCategoryNameWidget(
          category: 'Photos',
          marginTop: 420,
        ),
        ListPhotosWidget(photos: photos),
        DetailsCategoryNameWidget(
          category: 'Cast',
          marginTop: 635,
        ),
        ListCreditsWidget(
          creditsResponse: creditsResponse,
        ),
        DetailsCategoryNameWidget(
          category: 'Similar Movies',
          marginTop: 790,
        ),
        SimilarMoviesWidget(
            context: context,
            listResponseSimilarMovies: listResponseSimilarMovies,
            genresOfSimilarMovie: genresOfSimilarMovie),
      ],
    );
  }
}
