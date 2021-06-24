import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/detailspage/details_movie_bloc.dart';
import 'package:flutter_app/bloc/movies_genres/genres_bloc.dart';
import 'package:flutter_app/ui/containers/details_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({
    Key? key,
    required this.id,
    required this.sessionId,
  }) : super(key: key);

  final int id;
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<DetailsMovieBloc>(
            create: (BuildContext context) =>
                DetailsMovieBloc()..add(LoadDetailsPageEvent(id: id)),
          ),
          BlocProvider<GenresBloc>(
            create: (BuildContext context) =>
                GenresBloc()..add(LoadMovieGenresEvent()),
          ),
        ],
        child: DetailsContainer(
          id: id,
          sessionId: sessionId,
        ));
  }
}
