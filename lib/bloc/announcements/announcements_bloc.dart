import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/announcements/announcements_repository.dart';

part 'announcements_event.dart';
part 'announcements_state.dart';

class AnnouncementsInitial extends AnnouncementsState {}

class AnnouncementsLoadInProgress extends AnnouncementsState {}

class AnnouncementsLoadSuccess extends AnnouncementsState {
  final List<Announcements> announcements;

  const AnnouncementsLoadSuccess({@required this.announcements})
      : assert(announcements != null);

  @override
  List<Object> get props => [announcements];
}

class AnnouncementsLoadFailure extends AnnouncementsState {}

class AnnouncementsBloc extends Bloc<AnnouncementsEvent, AnnouncementsState> {
  final AnnouncementsRepository announcementsRepository;

  AnnouncementsBloc({@required this.announcementsRepository})
      : assert(announcementsRepository != null),
        super(AnnouncementsInitial());

  @override
  Stream<AnnouncementsState> mapEventToState(
    AnnouncementsEvent event,
  ) async* {
    try {
      final List announcements = await announcementsRepository.getData();
      yield AnnouncementsLoadSuccess(announcements: announcements);
    } catch (_) {}
  }
}
