import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/detailspage/details_movie_bloc.dart';
import 'package:flutter_app/bloc/search/search_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/screens/details_page_screen.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieSearch extends SearchDelegate<String> {
  List<String> data = ['cat', 'dog', 'parrot'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.close), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // List<String> suggestions = data.where((element) => element == query)
    //     .toList();

    // if (suggestions.isNotEmpty == true) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state.loading) {
        return LoadingWidget();
      }
      return ListView.builder(
        itemCount: state.listMovieModel?.length,
        itemBuilder: (BuildContext context, int index) {
          List<MovieModel>? suggestions = state.listMovieModel
              ?.where((element) => element.originalTitle == query)
              .toList();
          return ListTile(
            title: Text(
              '${suggestions?[index]}',
            ),
            onTap: () {
              final id = state.listMovieModel?[index].id;
              if (id != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //REVIEW has a lot fo data passed in that it shouldn't have
                      builder: (ctx) {
                    return DetailsScreen(
                      id: id,
                    );
                  }),
                );
              }
            },
          );
        },
      );
    });
    // }

    // return Column();

    // return ListView.builder(
    // itemCount: suggestions.length,
    // itemBuilder: (BuildContext context, int index) {
    // return ListTile(
    // title: Text(
    // suggestions[index],
    // ),
    // onTap: () {
    // Navigator.push(
    // context,
    // MaterialPageRoute(
    // //REVIEW has a lot fo data passed in that it shouldn't have
    // builder: (ctx) {
    // return DetailsScreen(
    // id: 337404,
    // );
    // }),
    // );
    // },
    // );
    // },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state == null) {
        return Column();
      }
      if (state.loading) {
        return LoadingWidget();
      }
      return ListView.builder(
        itemCount: state.listMovieModel?.length,
        itemBuilder: (BuildContext context, int index) {
          List<MovieModel>? suggestions = state.listMovieModel
              ?.where((element) => element.originalTitle == query)
              .toList();
          return ListTile(
            title: Text(
              '${suggestions?[index]}',
            ),
            onTap: () {
              showResults(context);
            },
          );
        },
      );
    });
  }

  // List<String> suggestions = data.where((element) => element == query)
  //     .toList();
  //
  // if (suggestions.isNotEmpty == true) {
  //   return ListView.builder(
  //     itemCount: suggestions.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return ListTile(
  //         title: Text(
  //             suggestions[index],
  //         ),
  //         onTap: () {
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }
  //

}
