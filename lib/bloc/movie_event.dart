abstract class MovieEvent {
  const MovieEvent();
}

class LoadedTrendingPageEvent extends MovieEvent {}

class LoadedUpcomingPageEvent extends MovieEvent {}

class LoadedPhotoPageEvent extends MovieEvent {}