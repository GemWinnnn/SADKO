part of 'campuses_bloc.dart';

@immutable
abstract class CampusesEvent {
  const CampusesEvent();
}

class CampusesRequested extends CampusesEvent {
  const CampusesRequested();

  @override
  List<Object> get props => [];
}
