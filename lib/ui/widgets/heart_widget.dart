import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/data/favorite_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Heart extends StatefulWidget {
  final int? id;
  final EdgeInsets padding;
  bool isFavorite;

  Heart(
      {Key? key,
      required this.id,
      this.padding = EdgeInsets.zero,
      this.isFavorite = false})
      : super(key: key);

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  Color _color = Colors.grey;
  Icon disabledIcon = Icon(Icons.favorite_border);
  Icon enabledIcon = Icon(Icons.favorite);
  Icon currentIcon = Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    if (widget.isFavorite) {
      _color = Colors.red;
      currentIcon = enabledIcon;
    } else {
      _color = Colors.grey;
      currentIcon = disabledIcon;
    }

    final currentId = widget.id;
    if (currentId != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: widget.padding,
            child: IconButton(
                icon: currentIcon,
                color: _color,
                onPressed: () {
                  setState(() {
                    widget.isFavorite == true
                        ? widget.isFavorite = false
                        : widget.isFavorite = true;

                    _color == Colors.grey
                        ? _color = Colors.red
                        : _color = Colors.grey;
                    currentIcon == enabledIcon
                        ? currentIcon = disabledIcon
                        : currentIcon = enabledIcon;
                  });
                  BlocProvider.of<AuthBloc>(context)
                    ..add(MarkAsFavoriteEvent(FavoriteRequest(
                        mediaId: currentId, favorite: widget.isFavorite)))
                    ..add(GetFavoriteMoviesEvent(FavoriteRequest()));
                }),
          )
        ],
      );
    }
    return Row();
  }
}
