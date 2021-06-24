import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/screens/details_page_screen.dart';
import 'package:flutter_app/ui/widgets/movie_trending_info_widget.dart';
import 'package:flutter_app/ui/widgets/movie_trending_header_widget.dart';

const kMovieContainerWidth = 334.0;

class MovieContainer extends StatelessWidget {
  final int number;
  final MovieModel? movieModel;
  final String sessionId;
  final bool isFavorite;

  //REVIEW introduce widgets for specific part of UI instead of all been in one file

  MovieContainer({
    Key? key,
    required this.number,
    required this.movieModel,
    required this.sessionId,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final id = movieModel?.id;
          if (id != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  //REVIEW has a lot fo data passed in that it shouldn't have
                  builder: (ctx) {
                return DetailsScreen(
                  id: id,
                  sessionId: sessionId,
                );
              }),
            );
          }
        },
        child: Container(
            width: kMovieContainerWidth,
            margin: EdgeInsets.fromLTRB(0, 4, 10, 0),
            child: Stack(children: [
              MovieTrendingHeaderWidget(
                movieModel: movieModel,
                number: number,
                sessionId: sessionId,
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
