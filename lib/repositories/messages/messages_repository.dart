import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/repositories/messages/messages_api.dart';

class MessagesRepository {
  final MessagesApiClient apiClient;

  MessagesRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<List> getData() async {
    return apiClient.fetchMessages();
  }
}
