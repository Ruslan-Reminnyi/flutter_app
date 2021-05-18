import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/movie_state.dart';
import 'package:flutter_app/bloc/photo_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/networking/response/list_photo_response.dart';
import 'package:flutter_app/ui/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AnotherScreen extends StatelessWidget {
  AnotherScreen({Key? key, required this.photos}) : super(key: key);

  final ListPhotoResponse? photos;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
      ),
      child: Stack(
        children: [
            Positioned(
              left: 20,
                top: 100,
                height: 155,
                width: 400,
                child: _listWidgetsPhotos()
            ),
        ],
      ),
    );
  }

  Widget _listWidgetsPhotos() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: photos?.backdrops?.length,
      itemBuilder: (ctx, index) {
        return Container(
          color: Colors.red,
          // height: 250,
          width: 280,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${photos?.backdrops?[index].path}",
                // fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

}
