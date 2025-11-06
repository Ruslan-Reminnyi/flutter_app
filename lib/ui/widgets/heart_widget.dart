// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/data/favorite_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Heart extends StatelessWidget {
  final int? id;
  final EdgeInsets padding;
  bool isFavorite;

  Heart({
    super.key,
    required this.id,
    this.padding = EdgeInsets.zero,
    this.isFavorite = false,
  });

  Color _color = Colors.grey;
  Icon disabledIcon = Icon(Icons.favorite_border);
  Icon enabledIcon = Icon(Icons.favorite);
  Icon currentIcon = Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (isFavorite) {
          _color = Colors.red;
          currentIcon = enabledIcon;
        } else {
          _color = Colors.grey;
          currentIcon = disabledIcon;
        }

        final currentId = id;
        if (authState is Authorized && currentId != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: padding,
                child: IconButton(
                  icon: currentIcon,
                  color: _color,
                  onPressed: () {
                    isFavorite == true ? isFavorite = false : isFavorite = true;

                    _color == Colors.grey
                        ? _color = Colors.red
                        : _color = Colors.grey;
                    currentIcon == enabledIcon
                        ? currentIcon = disabledIcon
                        : currentIcon = enabledIcon;

                    BlocProvider.of<AuthBloc>(context).add(
                      MarkAsFavoriteEvent(
                        request: FavoriteRequest(
                          mediaId: currentId,
                          favorite: isFavorite,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Row();
      },
    );
  }
}
