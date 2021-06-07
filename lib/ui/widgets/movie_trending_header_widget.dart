import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/utils.dart';

class MovieTrendingHeaderWidget extends StatelessWidget {
  MovieTrendingHeaderWidget(
      {Key? key, required this.movieModel, required this.number})
      : super(key: key);

  final int number;
  final MovieModel? movieModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          number < 10 ? '0$number' : '$number',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          movieModel?.originalTitle != null
              ? '${movieModel?.originalTitle}'
              : '${movieModel?.originalTitle}',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(
              getImagePath(movieModel?.backdropPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
