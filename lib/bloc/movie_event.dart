abstract class MovieEvent {
  const MovieEvent();
}

//REVIEW Event should be a verb.
// Noun in the past tense is the correct way to describe event but in bloc it's triggering actions
class LoadedTrendingPageEvent extends MovieEvent {}

class LoadedUpcomingPageEvent extends MovieEvent {}

class LoadedPhotoPageEvent extends MovieEvent {}