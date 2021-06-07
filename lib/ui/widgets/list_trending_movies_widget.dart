import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/movies_genres/genres_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/containers/movie_trending_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/bloc/homepage/trending/trending_movie_bloc.dart';

class ListTrendingMoviesWidget extends StatelessWidget {
  ListTrendingMoviesWidget(
      {Key? key, required this.listMovieModel, required this.genres})
      : super(key: key);

  final List<MovieModel>? listMovieModel;
  final List<String?> genres;

  final ScrollController _trendingScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listMovieModel?.length,
      controller: _trendingScrollController
        ..addListener(() {
          if (_trendingScrollController.position.pixels ==
              _trendingScrollController.position.maxScrollExtent) {
            BlocProvider.of<TrendingMovieBloc>(context)
                .add(LoadMoreTrendingMoviesEvent());
          }
        }),
      itemBuilder: (ctx, index) {
        BlocProvider.of<GenresBloc>(context).add(
            LoadMoreMovieGenresEvent(genres: listMovieModel?[index].genres));
        return MovieContainer(
          number: index + 1,
          movieModel: listMovieModel?[index],
          genres: genres[index],
        );
      },
    );
  }
}
