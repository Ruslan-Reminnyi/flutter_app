import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/bloc/detailspage/details_movie_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/widgets/details_stack_widget.dart';
import 'package:flutter_app/ui/widgets/heart_widget.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsContainer extends StatelessWidget {
  final int id;

  DetailsContainer({super.key, required this.id});

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
        actions: [LikeAction(id: id)],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<DetailsMovieBloc, DetailsMovieState>(
          builder: (context, state) {
            if (state.loading) {
              return LoadingWidget();
            }
            return DetailsStackWidget(
              id: id,
              movieDetailsResponse: state.movieDetailsResponse,
            );
          },
        ),
      ),
    );
  }
}

class LikeAction extends StatelessWidget {
  final int id;
  const LikeAction({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is Authorized) {
          var favorite = authState.favoritesList?.listMovieModel?.firstWhere(
            (element) => element.id == id,
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

          return Heart(id: id, isFavorite: isFavorite);
        } else {
          return Heart(id: id, isFavorite: false);
        }
      },
    );
  }
}
