import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/detailspage/details_movie_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/ui/widgets/details_stack_widget.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsContainer extends StatelessWidget {
  DetailsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          kAppTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      body: SingleChildScrollView(child:
          BlocBuilder<DetailsMovieBloc, DetailsMovieState>(
              builder: (context, state) {
        if (state is LoadedDetailsMoviesState) {
          return DetailsStackWidget(
            context: context,
            movieDetailsResponse: state.movieDetailsResponse,
            genresOfSimilarMovie: state.genresOfSimilarMovie,
          );
        }
        return LoadingWidget();
      })),
    );
  }
}
