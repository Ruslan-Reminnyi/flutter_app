import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/widgets/movie_trending_info_widget.dart';
import 'package:flutter_app/ui/widgets/movie_trending_header_widget.dart';

const kMovieContainerWidth = 334.0;

class MovieContainer extends StatelessWidget {
  final int number;
  final MovieModel? movieModel;
  final bool isFavorite;

  MovieContainer({
    Key? key,
    required this.number,
    required this.movieModel,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final id = movieModel?.id;
          if (id != null) {
            Navigator.pushNamed(context, '/details', arguments: id);
          }
        },
        child: Container(
            width: kMovieContainerWidth,
            margin: EdgeInsets.fromLTRB(0, 4, 10, 0),
            child: Stack(children: [
              MovieTrendingHeaderWidget(
                movieModel: movieModel,
                number: number,
                isFavorite: isFavorite,
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: MovieTrendingInfoWidget(
                    movieModel: movieModel, indexOfCurrentMovie: number - 1),
              ),
            ])));
  }
}
