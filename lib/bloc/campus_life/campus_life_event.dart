part of 'campus_life_bloc.dart';

@immutable
abstract class CampusLifeEvent {
  const CampusLifeEvent();
}

class CampusLifeRequested extends CampusLifeEvent {
  const CampusLifeRequested();

  @override
  List<Object> get props => [];
}
