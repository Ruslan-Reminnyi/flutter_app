import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/movies_genres/genres_bloc.dart';
import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/screens/details_page_screen.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_app/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kMovieComingSoonTextContainerHeight = 84.0;
const kCommonMovieListContainerHeight = 170.0;

class CommonMovieListWidget extends StatelessWidget {
  final MovieModel? movieModel;

  CommonMovieListWidget({
    Key? key,
    required this.movieModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final id = movieModel?.id;
        if (id != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                //REVIEW has a lot fo data passed in that it shouldn't have
                builder: (ctx) {
              return DetailsScreen(
                id: id,
              );
            }),
          );
        }
      },
      child: Container(
        width: kCommonMovieListContainerHeight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(
                    getImagePath(movieModel?.posterPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: kMovieComingSoonTextContainerHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: Text(
                        movieModel?.originalTitle ?? '',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Expanded(child: Genres(genres: movieModel?.genres)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Genres extends StatelessWidget {
  final List<int>? genres;

  const Genres({Key? key, required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenresBloc, GenresState>(builder: (context, state) {
      if (state.loading) {
        return LoadingWidget();
      }
      return Text(
        genresToList(genres, state.allApiGenres) ?? '',
        style: TextStyle(color: Colors.grey, fontSize: 10),
      );
    });
  }
}

String? genresToList(List<int>? genres, List<MovieGenresModel>? allGenresList) {
  var names = allGenresList
      ?.where((item) => genres?.contains(item.id) == true)
      .map((e) => e.name)
      .join(", ");

  return names;
}
