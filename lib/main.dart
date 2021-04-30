import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/movie_bloc.dart';
import 'package:flutter_app/bloc/movie_state.dart';
// import 'package:flutter_movi_demo/bloc/block_provider.dart';
// import 'package:flutter_movi_demo/bloc/fetch_movie_bloc.dart';
import 'package:flutter_app/ui/home_page_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Movie',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(create: (BuildContext context) => MovieBloc(AnotherPageState(pageNumber: 1)),
          child: HomeScreen(title: 'New Movie'))
    );
  }

}


