import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/movie_bloc.dart';
import 'package:flutter_app/bloc/movie_state.dart';
import 'package:flutter_app/data/movie_details_model.dart';
import 'package:flutter_app/data/movie_genres_model.dart';
// import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/networking/response/list_genres_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';
import 'package:flutter_app/ui/widgets/movie_coming_soon_container.dart';
import 'package:flutter_app/ui/widgets/movie_trending_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // var _trendingScrollController = ScrollController();
  // var _upcomingScrollController = ScrollController();

  int trendingPageNumber = 1;
  int upcomingPageNumber = 1;

  late Api _api;

  @override
  void initState() {

    // _trendingScrollController.addListener(() {
    //   if (_trendingScrollController.position.pixels ==
    //       _trendingScrollController.position.maxScrollExtent) {
    //
    //     _nextPageTrending();
    //     print("pageNumberOfTrending $trendingPageNumber");
    //
    //     _api.getTrendingMovies(trendingPageNumber);
    //   }
    //   if (_trendingScrollController.position.pixels ==
    //       _trendingScrollController.position.minScrollExtent && trendingPageNumber != 1) {
    //
    //     _previousPageTrending();
    //     print("pageNumberOfTrending $trendingPageNumber");
    //
    //     _api.getTrendingMovies(trendingPageNumber);
    //   }
    // });
    //
    // _upcomingScrollController.addListener(() {
    //   if (_upcomingScrollController.position.pixels ==
    //       _upcomingScrollController.position.maxScrollExtent) {
    //
    //     _nextPageUpcoming();
    //     print("pageNumberOfUpcoming $upcomingPageNumber");
    //
    //     _api.getUpcomingMovies(upcomingPageNumber);
    //   }
    //   if (_upcomingScrollController.position.pixels ==
    //       _upcomingScrollController.position.minScrollExtent && upcomingPageNumber != 1) {
    //
    //     _previousPageUpcoming();
    //     print("pageNumberOfUpcoming $upcomingPageNumber");
    //
    //     _api.getUpcomingMovies(upcomingPageNumber);
    //   }
    // });

    _api = Api();

    super.initState();
  }

  void _nextPageTrending() {
    setState(() {
      trendingPageNumber++;
    });
  }

  void _previousPageTrending() {
    setState(() {
      trendingPageNumber--;
    });
  }

  void _nextPageUpcoming() {
    setState(() {
      upcomingPageNumber++;
    });
  }

  void _previousPageUpcoming() {
    setState(() {
      upcomingPageNumber--;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.title,
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody (context) {

    var _movieBloc = BlocProvider.of<MovieBloc>(context);

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
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: FutureBuilder<ListResponse>(
                      future: _api.getTrendingMovies(trendingPageNumber),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // controller: _trendingScrollController,
                            itemCount: snapshot.data?.movies?.length,
                            itemBuilder: (ctx, index) {
                              return BlocBuilder<MovieBloc, CounterOfPagesState>(
                                builder: (context, state) {
                                return MovieContainer(number: _getCurrentNumberOfTheMovie(index+1),
                                    movieModel: snapshot.data?.movies?[index]);
                               },
                               );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                height: 290,
                child: FutureBuilder<ListResponse>(
                  future: _api.getUpcomingMovies(upcomingPageNumber),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // controller: _upcomingScrollController,
                        itemCount: snapshot.data?.movies?.length,
                        itemBuilder: (ctx, index) {
                          return MovieComingSoonContainer(movieModel: snapshot.data?.movies?[index]);
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  _getCurrentNumberOfTheMovie(int index) {
    return (trendingPageNumber - 1) * 20 + index;
  }

}

