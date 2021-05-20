import 'package:flutter_app/bloc/movie_event.dart';
import 'package:flutter_app/bloc/movie_state.dart';
import 'package:flutter_app/networking/api.dart';
import 'package:flutter_app/networking/response/list_photo_response.dart';
import 'package:flutter_app/networking/response/list_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_event.dart';

class PhotoBloc extends Bloc<MovieEvent, MovieState> {

  Api _api = Api();
  late ListResponse listResponseTrending;
  late List<ListPhotoResponse> listPhotoResponse;

  PhotoBloc() : super(MovieInitState());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {

    if(event is LoadedPhotoPageEvent) {
      yield* _loadedPhotos(event);
    }

  }

  Stream<MovieState> _loadedPhotos(MovieEvent movieEvent) async* {

    yield LoadingState();

    listResponseTrending = await _api.getTrendingMovies(1);

    // List<ListPhotoResponse> listPhotoResponse = [];

    List<int?>? listIdTaglines = listResponseTrending?.movies?.map((e) => e.id).toList();

    for(int? id in listIdTaglines!) {
      ListPhotoResponse currentPhotoResponse = await _api.getPhotosOfMovies(id);
      listPhotoResponse.add(currentPhotoResponse);
    }

    yield LoadedPhotosState(
      listPhotoResponse,
    );

  }

}