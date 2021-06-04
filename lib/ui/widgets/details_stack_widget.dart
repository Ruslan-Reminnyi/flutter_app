import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/widgets/details_category_name_widget.dart';
import 'package:flutter_app/ui/widgets/details_info_widget.dart';
import 'package:flutter_app/ui/widgets/list_credits_widget.dart';
import 'package:flutter_app/ui/widgets/list_photos_widget.dart';
import 'package:flutter_app/ui/widgets/similar_movies_widget.dart';
import 'package:flutter_app/utils.dart';

class DetailsStackWidget extends StatelessWidget {
  DetailsStackWidget(
      {Key? key,
      required this.context,
      required this.movieDetailsResponse,
      required this.listSimilarMovies,
      required this.genresOfSimilarMovie})
      : super(key: key);

  final BuildContext context;
  final MovieDetailsResponse movieDetailsResponse;
  final List<MovieModel>? listSimilarMovies;
  final List<String?> genresOfSimilarMovie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          //REVIEW should have all cases of image link construction as function not placed all over the place apply DRY principle
          getImagePath(movieDetailsResponse.backdropPath),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          //REVIEW magic numbers
          width: MediaQuery.of(context).size.width,
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
                    getImagePath(movieDetailsResponse.posterPath),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(
                  child: DetailsInfoWidget(
                    movieDetailsResponse: movieDetailsResponse,
                    creditsResponse: movieDetailsResponse.creditsResponse,
                  ),
                ),
                Container(
                  width: 70,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 60.0, 20.0, 0.0),
                    child: Image.network(
                      getImagePath(
                          movieDetailsResponse.productionCompanies == null
                              ? ""
                              : movieDetailsResponse
                                  .productionCompanies?.first.logoPath),
                      // fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 338),
          width: MediaQuery.of(context).size.width / 1.1,
          child: ShaderMask(
            shaderCallback: (_) => kLinearGradient.createShader(
              Rect.fromLTWH(0, 0, 0, 70),
            ),
            child: Text(
              movieDetailsResponse.overview ?? '',
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
          marginTop: photoDetailsMarginTop,
        ),
        ListPhotosWidget(photos: movieDetailsResponse.photoResponse),
        DetailsCategoryNameWidget(
          category: 'Cast',
          marginTop: castDetailsMarginTop,
        ),
        ListCreditsWidget(
          creditsResponse: movieDetailsResponse.creditsResponse,
        ),
        DetailsCategoryNameWidget(
          category: 'Similar Movies',
          marginTop: similarDetailsMarginTop,
        ),
        SimilarMoviesWidget(
            context: context,
            listResponseSimilarMovies: listSimilarMovies,
            genresOfSimilarMovie: genresOfSimilarMovie),
      ],
    );
  }
}
