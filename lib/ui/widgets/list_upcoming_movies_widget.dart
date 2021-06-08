import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/homepage/upcoming/upcoming_movie_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/containers/common_movie_list_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUpcomingMoviesWidget extends StatefulWidget {
  ListUpcomingMoviesWidget({Key? key, required this.listMovieModel})
      : super(key: key);

  final List<MovieModel>? listMovieModel;

  @override
  _ListUpcomingMoviesWidgetState createState() =>
      _ListUpcomingMoviesWidgetState();
}

class _ListUpcomingMoviesWidgetState extends State<ListUpcomingMoviesWidget> {
  final ScrollController _upcomingScrollController = ScrollController();

  @override
  void initState() {
    _upcomingScrollController.addListener(() {
      if (_upcomingScrollController.position.pixels ==
          _upcomingScrollController.position.maxScrollExtent) {
        BlocProvider.of<UpcomingMovieBloc>(context)
            .add(LoadMoreUpcomingMoviesEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _upcomingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.listMovieModel?.length,
      controller: _upcomingScrollController,
      itemBuilder: (ctx, index) {
        return CommonMovieListWidget(
          movieModel: widget.listMovieModel?[index],
        );
      },
    );
  }
}
