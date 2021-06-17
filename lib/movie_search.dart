import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/search/search_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/screens/details_page_screen.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_app/ui/widgets/search_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieSearch extends SearchDelegate<String> {
  final ScrollController scrollController = ScrollController();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = '';
          })
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
    BlocProvider.of<SearchBloc>(context).add(LoadSearchMovieEvent(query));

    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return Stack(
        children: [
          ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: state.listMovieModel?.length ?? 0,
            controller: scrollController
              ..addListener(() {
                if (scrollController.position.pixels ==
                    scrollController.position.maxScrollExtent) {
                  BlocProvider.of<SearchBloc>(context)
                      .add(LoadMoreSearchMovieEvent(query));
                }
              }),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  state.listMovieModel?[index].originalTitle ?? '',
                ),
                leading: SearchItem(
                    backdropsPath: state.listMovieModel?[index].backdropPath),
                onTap: () {
                  close(context, '');

                  final id = state.listMovieModel?[index].id;
                  if (id != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) {
                        return DetailsScreen(
                          id: id,
                        );
                      }),
                    );
                  }
                },
              );
            },
          ),
          state.loading ? LoadingWidget() : SizedBox(),
        ],
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(LoadSearchMovieEvent(query));

    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state.loading) {
        return LoadingWidget();
      }
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: state.listMovieModel?.length ?? 0,
        controller: scrollController
          ..addListener(() {
            if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
              BlocProvider.of<SearchBloc>(context)
                  .add(LoadMoreSearchMovieEvent(query));
            }
          }),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              state.listMovieModel?[index].originalTitle ?? '',
            ),
            leading: SearchItem(
                backdropsPath: state.listMovieModel?[index].backdropPath),
            onTap: () {
              showResults(context);
            },
          );
        },
      );
    });
  }
}

class SearchList extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  SearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state.loading) {
        return LoadingWidget();
      }
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: state.listMovieModel?.length ?? 0,
        controller: scrollController
          ..addListener(() {
            if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
              BlocProvider.of<SearchBloc>(context)
                  .add(LoadMoreSearchMovieEvent(context.read().query));
            }
          }),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              state.listMovieModel?[index].originalTitle ?? '',
            ),
            leading: SearchItem(
                backdropsPath: state.listMovieModel?[index].backdropPath),
            onTap: () {
              context.read().close(context, '');

              final id = state.listMovieModel?[index].id;
              if (id != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) {
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
  }
}
