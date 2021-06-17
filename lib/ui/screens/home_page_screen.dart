import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/bloc/homepage/upcoming/upcoming_movie_bloc.dart';
import 'package:flutter_app/bloc/homepage/trending/trending_movie_bloc.dart';
import 'package:flutter_app/movie_search.dart';
import 'package:flutter_app/ui/screens/webview_page_screen.dart';
import 'package:flutter_app/ui/widgets/list_trending_movies_widget.dart';
import 'package:flutter_app/ui/widgets/list_upcoming_movies_widget.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kHomePageTrendingMovieContainerHeight = 300.0;
const kHomePageComingSoonMovieContainerHeight = 310.0;

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) {
                    // BlocProvider.of<AuthBloc>(context)
                    //     .add(GetSessionIdEvent());
                    return WebViewPageScreen();
              }));
            }),
        title: Text(
          title,
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                await showSearch<String>(
                    context: context, delegate: MovieSearch());
              }),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Divider(
            color: Colors.grey,
            indent: 20,
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
              padding: EdgeInsets.symmetric(horizontal: 20),
            );
          }),
        ),
        SizedBox(
          height: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  //REVIEW it's better to introduce separate Widget completely instead of function that returns Widget

}
