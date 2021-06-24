import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/bloc/homepage/upcoming/upcoming_movie_bloc.dart';
import 'package:flutter_app/bloc/homepage/trending/trending_movie_bloc.dart';
import 'package:flutter_app/bloc/movies_genres/genres_bloc.dart';
import 'package:flutter_app/bloc/search/search_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/favorite_request.dart';

//REVIEW remove unused imports android studio does it automatically when formatting
import 'package:flutter_app/ui/screens/home_page_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TrendingMovieBloc>(
          create: (BuildContext context) =>
              TrendingMovieBloc()..add(LoadTrendingMoviesEvent()),
        ),
        BlocProvider<UpcomingMovieBloc>(
          create: (BuildContext context) =>
              UpcomingMovieBloc()..add(LoadUpcomingMoviesEvent()),
        ),
        BlocProvider<GenresBloc>(
          create: (BuildContext context) =>
              GenresBloc()..add(LoadMovieGenresEvent()),
        ),
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc()..add(GetTokenEvent(FavoriteRequest())),
        ),
      ],
      child: MaterialApp(
          title: kAppTitle,
          debugShowCheckedModeBanner: false,
          home: HomeScreen(title: kAppTitle)),
    );
  }
}
