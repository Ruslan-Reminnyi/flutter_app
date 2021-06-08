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
          padding: const EdgeInsets.only(left: 20), //REVIEW notice that it's uneven and effects listview by cutting items
          child: Column(
            children: [
              SizedBox(
                height: 15,//REVIEW3 even values only use dividable by 4 by default
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
                  id: movieDetailsResponse.id ?? 1, //REVIEW3 It must be impossible to open details screen without id, and id should be part of navigation
                  listResponseSimilarMovies: listSimilarMovies,
                  genresOfSimilarMovie: genresOfSimilarMovie),
            ],
          ),
        ),
      ],
    );
  }
}
