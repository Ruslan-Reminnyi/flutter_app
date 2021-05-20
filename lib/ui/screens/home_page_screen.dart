import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/homepage/upcoming/upcoming_movie_bloc.dart';
import 'package:flutter_app/bloc/homepage/trending/trending_movie_bloc.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_app/ui/widgets/movie_coming_soon_container.dart';
import 'package:flutter_app/ui/widgets/movie_trending_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: SizedBox(
            height: 30,
            child: Divider(
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            child: BlocBuilder<TrendingMovieBloc, TrendingMovieState>(
                builder: (context, state) {
              if (state is LoadedTrendingMoviesState) {
                return _listWidgetsTrendingMovies(
                    state.numbers, state.response, state.genres, state.tagline);
              }
              return LoadingWidget();
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 25, 0, 0),
          child: Column(
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
              Container(
                height: 290, //REVIEW magic numbers
                child: BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
                    builder: (context, state) {
                  if (state is LoadedUpcomingMoviesState) {
                    return _listWidgetsUpcomingMovies(
                        state.response, state.genres);
                  }
                  return LoadingWidget();
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //REVIEW it's better to introduce separate Widget completely instead of function that returns Widget
  Widget _listWidgetsTrendingMovies(List<int> numbers,
      ListResponse listResponse, List<String?> genres, List<String?> taglines) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listResponse.movies?.length,
        itemBuilder: (ctx, index) {
          return MovieContainer(
            number: numbers[index],
            movieModel: listResponse.movies?[index],
            genres: genres[index],
            tagline: taglines[index],
          );
        },
      ),
    );
  }

  Widget _listWidgetsUpcomingMovies(
      ListResponse listResponse, List<String?> genres) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listResponse.movies?.length,
        itemBuilder: (ctx, index) {
          return MovieComingSoonContainer(
            movieModel: listResponse.movies?[index],
            genres: genres[index],
          );
        },
      ),
    );
  }
}
