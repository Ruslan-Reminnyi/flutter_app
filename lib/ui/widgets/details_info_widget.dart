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
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            TitleMovie(movieDetailsResponse: movieDetailsResponse),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StarsRating(movieDetailsResponse: movieDetailsResponse),
                    SizedBox(
                      width: 5,
                    ),
                    TextRating(movieDetailsResponse: movieDetailsResponse),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Duration(movieDetailsResponse: movieDetailsResponse),
                    Genres(movieDetailsResponse: movieDetailsResponse),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                DirectorName(creditsResponse: creditsResponse),
                SizedBox(
                  height: 2,
                ),
                WriterName(creditsResponse: creditsResponse),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TitleMovie extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;
  const TitleMovie({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      movieDetailsResponse.originalTitle ?? '',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class StarsRating extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;

  const StarsRating({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: movieDetailsResponse.rating ?? 0.0,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 10,
      itemSize: 8.0,
      unratedColor: Colors.amber.withAlpha(50),
      direction: Axis.horizontal,
    );
  }
}

class TextRating extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;

  const TextRating({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("${movieDetailsResponse.rating}/10 IMDb",
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          decoration: TextDecoration.none,
        ));
  }
}

class Duration extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;

  const Duration({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      durationToHours(movieDetailsResponse),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 9,
        decoration: TextDecoration.none,
      ),
    );
  }

  String durationToHours(MovieDetailsResponse movieDetailsResponse) {
    int? runtime = movieDetailsResponse.runtime;

    int? hours = runtime! ~/ 60;

    int? minutes = runtime % 60;

    return minutes != 0 ? "${hours}h ${minutes}m | " : "${hours}h | ";
  }
}

class Genres extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;

  const Genres({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        getGenres(movieDetailsResponse) ?? '',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  String? getGenres(MovieDetailsResponse movieDetailsResponse) {
    return movieDetailsResponse.genres?.map((e) => e.name).join(", ");
  }
}

class DirectorName extends StatelessWidget {
  final CreditsResponse? creditsResponse;

  const DirectorName({Key? key, required this.creditsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      getNameOfDirector(creditsResponse) ?? "",
      style: TextStyle(
        fontSize: 9,
        color: Colors.white,
        decoration: TextDecoration.none,
      ),
    );
  }

  String? getNameOfDirector(CreditsResponse? creditsResponse) {
    var name = creditsResponse?.crew
        ?.firstWhere((element) => element.job == "Director",
            orElse: () => CrewModel(name: ""))
        .name;
    return "Director: $name";
  }
}

class WriterName extends StatelessWidget {
  final CreditsResponse? creditsResponse;

  const WriterName({Key? key, required this.creditsResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      getNameOfWriter(creditsResponse) ?? "",
      style: TextStyle(
        fontSize: 9,
        color: Colors.white,
        decoration: TextDecoration.none,
      ),
    );
  }

  String? getNameOfWriter(CreditsResponse? creditsResponse) {
    var name = creditsResponse?.crew
        ?.firstWhere((element) => element.department == "Writing",
            orElse: () => CrewModel(name: ""))
        .name;
    return "Writer: $name";
  }
}
