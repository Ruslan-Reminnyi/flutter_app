import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/movies_genres/genres_bloc.dart';
import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/widgets/heart_widget.dart';
import 'package:flutter_app/ui/widgets/network_image_widget.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kMovieComingSoonTextContainerHeight = 84.0;
const kCommonMovieListContainerHeight = 170.0;

class CommonMovieListWidget extends StatelessWidget {
  final MovieModel? movieModel;
  final bool isFavorite;

  CommonMovieListWidget({
    Key? key,
    required this.movieModel,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final id = movieModel?.id;
        if (id != null) {
          Navigator.pushNamed(context, '/details', arguments: id);
        }
      },
      child: Stack(
        children: [
          Container(
            width: kCommonMovieListContainerHeight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: NetworkImageWidget(
                          path: movieModel?.posterPath,
                        )),
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
          Heart(
            id: movieModel?.id,
            padding: EdgeInsets.only(left: 100.0),
            isFavorite: isFavorite,
          ),
        ],
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
