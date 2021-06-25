import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/containers/movie_trending_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/bloc/homepage/trending/trending_movie_bloc.dart';

class ListTrendingMoviesWidget extends StatefulWidget {
  ListTrendingMoviesWidget(
      {Key? key,
      required this.listMovieModel,
      this.padding = EdgeInsets.zero,
      required this.sessionId,
      required this.listFavoriteMovies})
      : super(key: key);

  final List<MovieModel>? listMovieModel;
  final EdgeInsets padding;
  final String sessionId;
  final List<MovieModel> listFavoriteMovies;

  @override
  _ListTrendingMoviesWidgetState createState() =>
      _ListTrendingMoviesWidgetState();
}

class _ListTrendingMoviesWidgetState extends State<ListTrendingMoviesWidget> {
  final ScrollController _trendingScrollController = ScrollController();

  @override
  void initState() {
    _trendingScrollController.addListener(() {
      if (_trendingScrollController.position.pixels ==
          _trendingScrollController.position.maxScrollExtent) {
        BlocProvider.of<TrendingMovieBloc>(context)
            .add(LoadMoreTrendingMoviesEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _trendingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.padding,
      scrollDirection: Axis.horizontal,
      itemCount: widget.listMovieModel?.length,
      controller: _trendingScrollController,
      itemBuilder: (ctx, index) {
        var favorite = widget.listFavoriteMovies.firstWhere(
            (element) => element.id == widget.listMovieModel?[index].id,
            orElse: () => MovieModel(
                id: 0,
                genres: [],
                rating: 0,
                backdropPath: '',
                originalName: '',
                originalTitle: '',
                posterPath: ''));

        bool isFavorite = favorite.id != 0 ? true : false;

        return MovieContainer(
          number: index + 1,
          movieModel: widget.listMovieModel?[index],
          sessionId: widget.sessionId,
          isFavorite: isFavorite,
          listFavoriteMovies: widget.listFavoriteMovies,
        );
      },
    );
  }
}
