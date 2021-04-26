import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_details_model.dart';
import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/networking/response/list_genres_response.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieContainer extends StatefulWidget {
  final MovieModel? movieModel;
  final int number;

  const MovieContainer({
    Key? key,
    required this.number,
    required this.movieModel,
  }) : super(key: key);

  @override
  _MovieContainerState createState() => _MovieContainerState();
}

class _MovieContainerState extends State<MovieContainer> {

  late int? movieId;

  late Api _api;

  @override
  void initState() {

  _api = Api();

  movieId = widget.movieModel?.id;

  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Details Screen"),
          ));

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (ctx) => DetailsScreen(id: snapshot.id),
        //   ),
        // );
      },
      child: Container(
          width: 335,
          margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.number < 10 ? '0${widget.number}' : '${widget.number}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.movieModel?.original_title}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/original${widget.movieModel?.backdrop_path}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      width: 325,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: widget.movieModel?.rating ?? 0.0,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 10,
                                itemSize: 8.0,
                                unratedColor: Colors.amber.withAlpha(50),
                                direction: Axis.horizontal,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${widget.movieModel?.rating}/10 IMDb",
                                style: TextStyle(fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FutureBuilder<MovieDetailsModel>(
                            future: _api.getDetailsOfMovies(movieId),
                            builder: (ctx, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                return Text(
                                    "${snapshot.data?.tagline}",
                                    style: TextStyle(fontSize: 14, color: Colors.white),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FutureBuilder<ListGenresResponse>(
                            future: _api.getGenresOfMovies(),
                            builder: (ctx, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                var genresNumbersOfCurrentMovie = widget.movieModel?.genres?.length as num;
                                var genresNumbers = snapshot.data?.genres?.length as num;
                                var buffer = StringBuffer();
                                String separator = ", ";
                                String? genresNames;

                                for (var i = 0; i < genresNumbersOfCurrentMovie; i++) {
                                  for (var j = 0; j < genresNumbers; j++) {

                                    if(widget.movieModel?.genres?[i]  ==
                                        snapshot.data?.genres?[j].id) {
                                      buffer.write(snapshot?.data?.genres?[j]?.name);
                                      if(i != genresNumbersOfCurrentMovie-1) {
                                        buffer.write(separator);
                                      }
                                      }

                                  }
                                }

                                genresNames = buffer.toString();

                                return Text(
                                    "$genresNames",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
      ),
        );
  }
}
