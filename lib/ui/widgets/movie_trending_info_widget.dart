import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/movies_genres/genres_bloc.dart';
import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieTrendingInfoWidget extends StatelessWidget {
  MovieTrendingInfoWidget(
      {Key? key, required this.movieModel, required this.indexOfCurrentMovie})
      : super(key: key);

  final MovieModel? movieModel;
  final int indexOfCurrentMovie;

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
              width: 4,
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
          height: 6,
        ),
        Genres(genres: movieModel?.genres),
        SizedBox(
          height: 4,
        ),
      ],
    );
  }
}

class Genres extends StatelessWidget {
  final List<int>? genres;

  const Genres({Key? key, required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenresBloc, GenresState>(builder: (context, state) {
      if (state.loading) {
        return LoadingWidget();
      }
      return Text(
        genresToList(genres, state.allApiGenres) ?? '',
        style: TextStyle(color: Colors.white, fontSize: 10),
      );
    });
  }
}

String? genresToList(List<int>? genres, List<MovieGenresModel>? allGenresList) {
  var names = allGenresList
      ?.where((item) => genres?.contains(item.id) == true)
      .map((e) => e.name)
      .join(", ");

  return names;
}
