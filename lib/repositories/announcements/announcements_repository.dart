import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/announcements/announcements_api.dart';

class AnnouncementsRepository {
  final AnnouncementsApiClient apiClient;

  AnnouncementsRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<Announcements> getData() async {
    return apiClient.fetchAnnouncements();
  }
}
