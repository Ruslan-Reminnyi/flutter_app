import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/ui/widgets/details_header.dart';
import 'package:flutter_app/ui/widgets/list_credits_widget.dart';
import 'package:flutter_app/ui/widgets/list_photos_widget.dart';
import 'package:flutter_app/ui/widgets/list_similar_movies_widget.dart';

class DetailsStackWidget extends StatelessWidget {
  DetailsStackWidget(
      {Key? key, required this.id, required this.movieDetailsResponse})
      : super(key: key);

  final int id;
  final MovieDetailsResponse movieDetailsResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailsHeader(movieDetailsResponse: movieDetailsResponse),
        Column(
          children: [
            SizedBox(
              height: 16,
            ),
            ListPhotosWidget(
              photos: movieDetailsResponse.photoResponse,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            SizedBox(
              height: 14,
            ),
            ListCreditsWidget(
              creditsResponse: movieDetailsResponse.creditsResponse,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            SizedBox(
              height: 16,
            ),
            ListSimilarMoviesWidget(
              id: id,
              listResponseSimilarMovies:
                  movieDetailsResponse.listSimilarMovies?.movies,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ],
        ),
      ],
    );
  }
}
