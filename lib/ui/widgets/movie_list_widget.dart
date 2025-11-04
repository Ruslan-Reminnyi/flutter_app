import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/containers/common_movie_list_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
      return ListView.builder(
        padding: widget.padding,
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies?.length,
        controller: scrollController,
        itemBuilder: (ctx, index) {
          if (authState is Authorized) {
            var favorite = authState.favoritesList?.listMovieModel?.firstWhere(
                (element) => element.id == widget.movies?[index].id,
                orElse: () => MovieModel(
                    id: 0,
                    genres: [],
                    rating: 0,
                    backdropPath: '',
                    originalName: '',
                    originalTitle: '',
                    posterPath: ''));

            bool isFavorite =
                favorite?.id != 0 && favorite?.id != null ? true : false;

            return CommonMovieListWidget(
              movieModel: widget.movies?[index],
              isFavorite: isFavorite,
            );
          }
          return CommonMovieListWidget(
            movieModel: widget.movies?[index],
            isFavorite: false,
          );
        },
      );
    });
  }
}
