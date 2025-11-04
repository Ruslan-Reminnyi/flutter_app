import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/homepage/upcoming/upcoming_movie_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/widgets/movie_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUpcomingMoviesWidget extends StatelessWidget {
  ListUpcomingMoviesWidget(
      {Key? key, required this.listMovieModel, this.padding = EdgeInsets.zero})
      : super(key: key);

  final List<MovieModel>? listMovieModel;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MovieList(
      padding: padding,
      movies: listMovieModel,
      loadMore: () {
        BlocProvider.of<UpcomingMovieBloc>(context)
            .add(LoadMoreUpcomingMoviesEvent());
      },
    );
  }
}
