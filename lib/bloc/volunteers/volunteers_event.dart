part of 'volunteers_bloc.dart';

@immutable
abstract class VolunteersEvent {
  const VolunteersEvent();
}

class VolunteersRequested extends VolunteersEvent {
  const VolunteersRequested();

  @override
  List<Object> get props => [];
}
