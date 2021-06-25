import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/containers/common_movie_list_container.dart';

class MovieList extends StatefulWidget {
  final EdgeInsets padding;
  final List<MovieModel>? movies;

  final Function loadMore;
  final String sessionId;
  final List<MovieModel> listFavoriteMovies;

  const MovieList(
      {Key? key,
      required this.padding,
      required this.movies,
      required this.loadMore,
      required this.sessionId,
        required this.listFavoriteMovies})
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
        var favorite = widget.listFavoriteMovies.firstWhere(
                (element) => element.id == widget.movies?[index].id,
            orElse: () => MovieModel(
                id: 0,
                genres: [],
                rating: 0,
                backdropPath: '',
                originalName: '',
                originalTitle: '',
                posterPath: ''));

        bool isFavorite = favorite.id != 0 ? true : false;

        return CommonMovieListWidget(
          movieModel: widget.movies?[index],
          sessionId: widget.sessionId,
          isFavorite: isFavorite,
          listFavoriteMovies: widget.listFavoriteMovies,
        );
      },
    );
  }
}
