import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/widgets/movie_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFavoriteMoviesWidget extends StatelessWidget {
  ListFavoriteMoviesWidget({
    super.key,
    required this.listMovieModel,
    this.padding = EdgeInsets.zero,
  });

  final List<MovieModel>? listMovieModel;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MovieList(
      padding: padding,
      movies: listMovieModel,
      loadMore: () {
        BlocProvider.of<AuthBloc>(context).add(GetMoreFavoriteMoviesEvent());
      },
    );
  }
}
