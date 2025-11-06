import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/containers/movie_trending_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/bloc/homepage/trending/trending_movie_bloc.dart';

class ListTrendingMoviesWidget extends StatefulWidget {
  ListTrendingMoviesWidget({
    super.key,
    required this.listMovieModel,
    this.padding = EdgeInsets.zero,
  });

  final List<MovieModel>? listMovieModel;
  final EdgeInsets padding;

  @override
  ListTrendingMoviesWidgetState createState() =>
      ListTrendingMoviesWidgetState();
}

class ListTrendingMoviesWidgetState extends State<ListTrendingMoviesWidget> {
  final ScrollController _trendingScrollController = ScrollController();

  @override
  void initState() {
    _trendingScrollController.addListener(() {
      if (_trendingScrollController.position.pixels ==
          _trendingScrollController.position.maxScrollExtent) {
        BlocProvider.of<TrendingMovieBloc>(
          context,
        ).add(LoadMoreTrendingMoviesEvent());
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return ListView.builder(
          padding: widget.padding,
          scrollDirection: Axis.horizontal,
          itemCount: widget.listMovieModel?.length,
          controller: _trendingScrollController,
          itemBuilder: (ctx, index) {
            if (authState is Authorized) {
              var favorite = authState.favoritesList?.listMovieModel
                  ?.firstWhere(
                    (element) => element.id == widget.listMovieModel?[index].id,
                    orElse: () => MovieModel(
                      id: 0,
                      genres: [],
                      rating: 0,
                      backdropPath: '',
                      originalName: '',
                      originalTitle: '',
                      posterPath: '',
                    ),
                  );

              bool isFavorite = favorite?.id != 0 && favorite?.id != null
                  ? true
                  : false;

              return MovieContainer(
                number: index + 1,
                movieModel: widget.listMovieModel?[index],
                isFavorite: isFavorite,
              );
            }
            return MovieContainer(
              number: index + 1,
              movieModel: widget.listMovieModel?[index],
              isFavorite: false,
            );
          },
        );
      },
    );
  }
}
