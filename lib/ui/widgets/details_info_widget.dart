import 'package:flutter/material.dart';
import 'package:flutter_app/data/credits_response.dart';
import 'package:flutter_app/data/crew_model.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsInfoWidget extends StatelessWidget {
  DetailsInfoWidget(
      {Key? key,
      required this.movieDetailsResponse,
      required this.creditsResponse})
      : super(key: key);

  final MovieDetailsResponse movieDetailsResponse;
  final CreditsResponse? creditsResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
          child: Text(
            movieDetailsResponse.originalTitle ?? '',
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  RatingBarIndicator(
                    rating: movieDetailsResponse.rating ?? 0.0,
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
                    "${movieDetailsResponse.rating}/10 IMDb",
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
                    durationToHours(movieDetailsResponse),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      getGenres(movieDetailsResponse) ?? '',
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
                getNameOfDirector(creditsResponse) ?? "",
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
                getNameOfWriter(creditsResponse) ?? "",
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  String? getGenres(MovieDetailsResponse movieDetailsResponse) {
    return movieDetailsResponse.genres?.map((e) => e.name).join(", ");
  }

  String durationToHours(MovieDetailsResponse movieDetailsResponse) {
    int? runtime = movieDetailsResponse.runtime;

    int? hours = runtime! ~/ 60;

    int? minutes = runtime % 60;

    return minutes != 0 ? "${hours}h ${minutes}m | " : "${hours}h | ";
  }

  String? getNameOfDirector(CreditsResponse? creditsResponse) {
    var name = creditsResponse?.crew
        ?.firstWhere((element) => element.job == "Director",
            orElse: () => CrewModel(name: ""))
        .name;
    return "Director: $name";
  }

  String? getNameOfWriter(CreditsResponse? creditsResponse) {
    var name = creditsResponse?.crew
        ?.firstWhere((element) => element.department == "Writing",
            orElse: () => CrewModel(name: ""))
        .name;
    return "Writer: $name";
  }
}
