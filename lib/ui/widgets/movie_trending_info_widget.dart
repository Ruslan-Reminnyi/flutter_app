import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieTrendingInfoWidget extends StatelessWidget {
  MovieTrendingInfoWidget(
      {Key? key,
      required this.movieModel,
      required this.genres,
      required this.tagline})
      : super(key: key);

  final MovieModel? movieModel;
  final String? genres;
  final String? tagline;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          tagline ?? '',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          genres ?? '',
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
