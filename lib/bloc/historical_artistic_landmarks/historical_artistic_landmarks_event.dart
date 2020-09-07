part of 'historical_artistic_landmarks_bloc.dart';

@immutable
abstract class HistoricalArtisticLandmarksEvent {
  const HistoricalArtisticLandmarksEvent();
}

class HistoricalArtisticLandmarksRequested
    extends HistoricalArtisticLandmarksEvent {
  const HistoricalArtisticLandmarksRequested();

  @override
  List<Object> get props => [];
}
