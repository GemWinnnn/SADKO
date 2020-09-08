import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/academic_buildings/academic_buildings_repository.dart';

part 'academic_buildings_event.dart';
part 'academic_buildings_state.dart';

class AcademicBuildingsInitial extends AcademicBuildingsState {}

class AcademicBuildingsLoadInProgress extends AcademicBuildingsState {}

class AcademicBuildingsLoadSuccess extends AcademicBuildingsState {
  final List<AcademicBuildings> academic_buildings;

  const AcademicBuildingsLoadSuccess({@required this.academic_buildings})
      : assert(academic_buildings != null);

  @override
  List<Object> get props => [academic_buildings];
}

class AcademicBuildingsLoadFailure extends AcademicBuildingsState {}

class AcademicBuildingsBloc
    extends Bloc<AcademicBuildingsEvent, AcademicBuildingsState> {
  final AcademicBuildingsRepository academicBuildingsRepository;

  AcademicBuildingsBloc({@required this.academicBuildingsRepository})
      : assert(academicBuildingsRepository != null),
        super(AcademicBuildingsInitial());

  @override
  Stream<AcademicBuildingsState> mapEventToState(
    AcademicBuildingsEvent event,
  ) async* {
    try {
      final List academic_buildings =
          await academicBuildingsRepository.getData();
      yield AcademicBuildingsLoadSuccess(
          academic_buildings: academic_buildings);
    } catch (_) {}
  }
}
