import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/historical_artistic_landmarks/historical_artistic_landmarks_repository.dart';

part 'historical_artistic_landmarks_event.dart';
part 'historical_artistic_landmarks_state.dart';

class HistoricalArtisticLandmarksInitial
    extends HistoricalArtisticLandmarksState {}

class HistoricalArtisticLandmarksLoadInProgress
    extends HistoricalArtisticLandmarksState {}

class HistoricalArtisticLandmarksLoadSuccess
    extends HistoricalArtisticLandmarksState {
  final List<HistoricalArtisticLandmarks> historicalArtisticLandmarks;

  const HistoricalArtisticLandmarksLoadSuccess(
      {@required this.historicalArtisticLandmarks})
      : assert(historicalArtisticLandmarks != null);

  @override
  List<Object> get props => [historicalArtisticLandmarks];
}

class HistoricalArtisticLandmarksLoadFailure
    extends HistoricalArtisticLandmarksState {}

class HistoricalArtisticLandmarksBloc extends Bloc<
    HistoricalArtisticLandmarksEvent, HistoricalArtisticLandmarksState> {
  final HistoricalArtisticLandmarksRepository
      historicalArtisticLandmarksRepository;

  HistoricalArtisticLandmarksBloc(
      {@required this.historicalArtisticLandmarksRepository})
      : assert(historicalArtisticLandmarksRepository != null),
        super(HistoricalArtisticLandmarksInitial());

  @override
  Stream<HistoricalArtisticLandmarksState> mapEventToState(
    HistoricalArtisticLandmarksEvent event,
  ) async* {
    try {
      final List historicalArtisticLandmarks =
          await historicalArtisticLandmarksRepository.getData();
      yield HistoricalArtisticLandmarksLoadSuccess(
          historicalArtisticLandmarks: historicalArtisticLandmarks);
    } catch (_) {}
  }
}
