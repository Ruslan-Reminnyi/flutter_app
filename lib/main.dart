import 'package:flutter/material.dart';
// import 'package:flutter_movi_demo/bloc/block_provider.dart';
// import 'package:flutter_movi_demo/bloc/fetch_movie_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container(
          child: Text('dsfds')
        ),
    );
  }


// @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     bloc: MovieBloc(),
  //     child: MaterialApp(
  //       title: 'Flutter Demo',
  //       debugShowCheckedModeBanner: false,
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //       ),
  //       home: HomeScreen(),
  //     ),
  //   );
  // }
}


