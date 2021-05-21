import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/screens/details_page_screen.dart';
import 'package:flutter_app/ui/widgets/movie_trending_info_widget.dart';
import 'package:flutter_app/ui/widgets/movie_trending_title_and_backdrop_widget.dart';

class MovieContainer extends StatelessWidget {
  final int number;
  final MovieModel? movieModel;
  final String? genres;
  final String? tagline;

  //REVIEW introduce widgets for specific part of UI instead of all been in one file

  MovieContainer({
    Key? key,
    required this.number,
    required this.movieModel,
    required this.genres,
    required this.tagline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Details Screen ${movieModel?.genres}"),
          ));

          Navigator.push(
            context,
            MaterialPageRoute(
                //REVIEW has a lot fo data passed in that it shouldn't have
                builder: (ctx) {
              return DetailsScreen(
                id: movieModel?.id,
              );
            }),
          );
        },
        child: Container(
            width: 335,
            margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
            child: Stack(children: [
              MovieTrendingTitleAndBackdropWidget(
                  movieModel: movieModel, number: number),
              Positioned(
                bottom: 10,
                left: 10,
                child: MovieTrendingInfoWidget(
                    movieModel: movieModel, genres: genres, tagline: tagline),
              ),
            ])));
  }
}
