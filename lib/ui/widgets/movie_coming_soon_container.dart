import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/networking/response/list_genres_response.dart';

class MovieComingSoonContainer extends StatefulWidget {
  final MovieModel? movieModel;

  const MovieComingSoonContainer({
    Key? key,
    required this.movieModel,
  }) : super(key: key);

  @override
  _MovieComingSoonContainerState createState() => _MovieComingSoonContainerState();
}

class _MovieComingSoonContainerState extends State<MovieComingSoonContainer> {

  late Api _api;

  @override
  void initState() {

    _api = Api();

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
        width: MediaQuery.of(context).size.width / 2.75,
        margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original${widget.movieModel?.poster_path}",
                      fit: BoxFit.cover,
                    ),
                  ),
              ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movieModel?.original_title ?? '',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Container(
                        child: FutureBuilder<ListGenresResponse>(
                          future: _api.getGenresOfMovies(),
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                              var genresNumbersOfCurrentMovie = widget.movieModel?.genres?.length as num;
                              var allGenresNumbers = snapshot.data?.genres?.length as num;
                              var buffer = StringBuffer();
                              String separator = ", ";
                              String? genresNames;

                              for (var i = 0; i < genresNumbersOfCurrentMovie; i++) {
                                for (var j = 0; j < allGenresNumbers; j++) {

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
                                style: TextStyle(color: Colors.grey, fontSize: 10),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

}
