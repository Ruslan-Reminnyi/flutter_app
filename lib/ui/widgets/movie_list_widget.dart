import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/containers/common_movie_list_container.dart';

class MovieList extends StatefulWidget {
  final EdgeInsets padding;
  final List<MovieModel>? movies;

  final Function loadMore;

  const MovieList(
      {Key? key,
      required this.padding,
      required this.movies,
      required this.loadMore})
      : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        widget.loadMore();
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
      itemCount: widget.movies?.length,
      controller: scrollController,
      itemBuilder: (ctx, index) {
        return CommonMovieListWidget(
          movieModel: widget.movies?[index],
        );
      },
    );
  }
}
