import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/data/favorite_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isFavorite = false;

class Heart extends StatefulWidget {
  final int? id;
  final EdgeInsets padding;

  const Heart({Key? key, required this.id, this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  @override
  Widget build(BuildContext context) {
    final currentId = widget.id;
    if (currentId != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: widget.padding,
            child: isFavorite
                ? IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      BlocProvider.of<AuthBloc>(context).add(
                          MarkAsFavoriteEvent(FavoriteRequest(
                              mediaType: "movie",
                              mediaId: currentId,
                              favorite: true)));
                    })
                : IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      BlocProvider.of<AuthBloc>(context).add(
                          MarkAsFavoriteEvent(FavoriteRequest(
                              mediaType: "movie",
                              mediaId: currentId,
                              favorite: false)));
                    }),
          )
        ],
      );
    }
    return Row();
  }
}
