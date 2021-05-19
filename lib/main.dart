import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/photo_bloc.dart';
import 'package:flutter_app/bloc/upcoming_movie_bloc.dart';
import 'package:flutter_app/bloc/trending_movie_bloc.dart';
import 'package:flutter_app/bloc/movie_event.dart';
import 'package:flutter_app/bloc/movie_state.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/networking/response/list_response.dart';
// import 'package:flutter_movi_demo/bloc/block_provider.dart';
// import 'package:flutter_movi_demo/bloc/fetch_movie_bloc.dart';
//REVIEW remove unused imports android studio does it automatically when formatting
import 'package:flutter_app/ui/screens/home_page_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Movie',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
            BlocProvider<TrendingMovieBloc>(
              create: (BuildContext context) => TrendingMovieBloc()..add(LoadedTrendingPageEvent()),
            ),
            BlocProvider<UpcomingMovieBloc>(
              create: (BuildContext context) => UpcomingMovieBloc()..add(LoadedUpcomingPageEvent()),
            ),
          ],
          child: HomeScreen(title: 'New Movie')),

    );
  }

}


