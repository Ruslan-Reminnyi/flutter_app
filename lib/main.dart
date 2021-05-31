import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/homepage/upcoming/upcoming_movie_bloc.dart';
import 'package:flutter_app/bloc/homepage/trending/trending_movie_bloc.dart';
import 'package:flutter_app/constants.dart';

//REVIEW remove unused imports android studio does it automatically when formatting
import 'package:flutter_app/ui/screens/home_page_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(providers: [
        BlocProvider<TrendingMovieBloc>(
          create: (BuildContext context) =>
              TrendingMovieBloc()..add(LoadTrendingPageEvent()),
        ),
        BlocProvider<UpcomingMovieBloc>(
          create: (BuildContext context) =>
              UpcomingMovieBloc()..add(LoadUpcomingPageEvent(1)),
        ),
      ], child: HomeScreen(title: kAppTitle)),
    );
  }
}
