import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/repositories/historical_artistic_landmarks/historical_artistic_landmarks_api.dart';

class HistoricalArtisticLandmarksRepository {
  final HistoricalArtisticLandmarksApiClient apiClient;

  HistoricalArtisticLandmarksRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<List> getData() async {
    return apiClient.fetchHistoricalArtisticLandmarks();
  }
}
