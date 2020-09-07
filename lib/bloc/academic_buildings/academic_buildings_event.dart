part of 'academic_buildings_bloc.dart';

@immutable
abstract class AcademicBuildingsEvent {
  const AcademicBuildingsEvent();
}

class AcademicBuildingsRequested extends AcademicBuildingsEvent {
  const AcademicBuildingsRequested();

  @override
  List<Object> get props => [];
}
