import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/widgets/details_header.dart';
import 'package:flutter_app/ui/widgets/list_credits_widget.dart';
import 'package:flutter_app/ui/widgets/list_photos_widget.dart';
import 'package:flutter_app/ui/widgets/similar_movies_widget.dart';

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
    return Column(
      children: [
        DetailsHeader(movieDetailsResponse: movieDetailsResponse),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              ListPhotosWidget(photos: movieDetailsResponse.photoResponse),
              SizedBox(
                height: 15,
              ),
              ListCreditsWidget(
                creditsResponse: movieDetailsResponse.creditsResponse,
              ),
              SizedBox(
                height: 15,
              ),
              ListSimilarMoviesWidget(
                  id: movieDetailsResponse.id ?? 1,
                  listResponseSimilarMovies: listSimilarMovies,
                  genresOfSimilarMovie: genresOfSimilarMovie),
            ],
          ),
        ),
      ],
    );
  }
}
