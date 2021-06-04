import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/detailspage/details_movie_bloc.dart';
import 'package:flutter_app/ui/containers/details_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsMovieBloc>(
        create: (BuildContext context) =>
            DetailsMovieBloc()..add(LoadDetailsPageEvent(id: id)),
        child: DetailsContainer());
  }
}
