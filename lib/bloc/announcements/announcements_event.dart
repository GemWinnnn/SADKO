part of 'announcements_bloc.dart';

@immutable
abstract class AnnouncementsEvent {
  const AnnouncementsEvent();
}

class AnnouncementsRequested extends AnnouncementsEvent {
  const AnnouncementsRequested();

  @override
  List<Object> get props => [];
}
