import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/bloc/homepage/upcoming/upcoming_movie_bloc.dart';
import 'package:flutter_app/bloc/homepage/trending/trending_movie_bloc.dart';
import 'package:flutter_app/bloc/movies_genres/genres_bloc.dart';
import 'package:flutter_app/bloc/search/search_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/ui/screens/details_page_screen.dart';
import 'package:flutter_app/ui/screens/home_page_screen.dart';
import 'package:flutter_app/ui/screens/webview_page_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          create: (BuildContext context) => AuthBloc()..add(GetTokenEvent()),
        ),
      ],
      child: MaterialApp(
        title: kAppTitle,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          if (settings.name == WebViewPageScreen.routeName) {
            final args = settings.arguments as String;

            return MaterialPageRoute(
              builder: (context) {
                return WebViewPageScreen(token: args);
              },
            );
          }
          if (settings.name == DetailsScreen.routeName) {
            final args = settings.arguments as int;

            return MaterialPageRoute(
              builder: (context) {
                return DetailsScreen(id: args);
              },
            );
          }
          return null;
        },
        home: HomeScreen(title: kAppTitle),
      ),
    );
  }
}
