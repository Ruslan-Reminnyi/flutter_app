import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/detailspage/details_movie_bloc.dart';
import 'package:flutter_app/bloc/homepage/upcoming/upcoming_movie_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/containers/common_movie_list_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListviewWidget extends StatefulWidget {
  final int id;
  final KindOfWidget kindOfWidget;
  final EdgeInsets padding;
  final List<MovieModel>? listMovieModel;

  const ListviewWidget(
      {Key? key,
      required this.padding,
      required this.listMovieModel,
      required this.kindOfWidget,
      required this.id})
      : super(key: key);

  @override
  _ListviewWidgetState createState() => _ListviewWidgetState();
}

class _ListviewWidgetState extends State<ListviewWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        switch (widget.kindOfWidget) {
          case KindOfWidget.upcoming:
            BlocProvider.of<UpcomingMovieBloc>(context)
                .add(LoadMoreUpcomingMoviesEvent());
            break;
          case KindOfWidget.similar:
            BlocProvider.of<DetailsMovieBloc>(context)
                .add(LoadMoreDetailsPageEvent(id: widget.id));
            break;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.padding,
      scrollDirection: Axis.horizontal,
      itemCount: widget.listMovieModel?.length,
      controller: scrollController,
      itemBuilder: (ctx, index) {
        return CommonMovieListWidget(
          movieModel: widget.listMovieModel?[index],
        );
      },
    );
  }
}
