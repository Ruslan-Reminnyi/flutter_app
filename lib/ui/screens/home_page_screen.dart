import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/homepage/upcoming/upcoming_movie_bloc.dart';
import 'package:flutter_app/bloc/homepage/trending/trending_movie_bloc.dart';
import 'package:flutter_app/ui/widgets/list_trending_movies_widget.dart';
import 'package:flutter_app/ui/widgets/list_upcoming_movies_widget.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          title,
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Container(
            height: kHomePageTrendingMovieContainerHeight,
            child: BlocBuilder<TrendingMovieBloc, TrendingMovieState>(
                builder: (context, state) {
              if (state.loading) {
                return LoadingWidget();
              }
              return ListTrendingMoviesWidget(
                  listMovieModel: state.listMovieModel,
                  genres: state.currentGenres);
            }),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height:
                    kHomePageComingSoonMovieContainerHeight, //REVIEW magic numbers
                child: BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
                    builder: (context, state) {
                  if (state.loading) {
                    return LoadingWidget();
                  }
                  return ListUpcomingMoviesWidget(
                      listMovieModel: state.listMovieModel,
                      genres: state.currentGenres);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //REVIEW it's better to introduce separate Widget completely instead of function that returns Widget

}
