part of 'colleges_bloc.dart';

@immutable
abstract class CollegesEvent {
  const CollegesEvent();
}

class CollegesRequested extends CollegesEvent {
  const CollegesRequested();

  @override
  List<Object> get props => [];
}
