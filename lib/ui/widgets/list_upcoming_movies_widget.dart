import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/homepage/upcoming/upcoming_movie_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/containers/common_movie_list_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUpcomingMoviesWidget extends StatelessWidget {
  ListUpcomingMoviesWidget(
      {Key? key, required this.listMovieModel, required this.genres})
      : super(key: key);

  final List<MovieModel>? listMovieModel;
  final List<String?> genres;

  final ScrollController _upcomingScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listMovieModel?.length,
      controller: _upcomingScrollController
        ..addListener(() {
          if (_upcomingScrollController.position.pixels ==
              _upcomingScrollController.position.maxScrollExtent) {
            BlocProvider.of<UpcomingMovieBloc>(context)
                .add(LoadMoreUpcomingMoviesEvent());
          }
        }),
      itemBuilder: (ctx, index) {
        return CommonMovieListWidget(
          movieModel: listMovieModel?[index],
          genres: genres[index],
        );
      },
    );
  }
}
