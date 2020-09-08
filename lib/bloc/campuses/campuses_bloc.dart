import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/campuses/campuses_repository.dart';

part 'campuses_event.dart';
part 'campuses_state.dart';

class CampusesInitial extends CampusesState {}

class CampusesLoadInProgress extends CampusesState {}

class CampusesLoadSuccess extends CampusesState {
  final List<Campuses> campuses;

  const CampusesLoadSuccess({@required this.campuses})
      : assert(campuses != null);

  @override
  List<Object> get props => [campuses];
}

class CampusesLoadFailure extends CampusesState {}

class CampusesBloc extends Bloc<CampusesEvent, CampusesState> {
  final CampusesRepository campusesRepository;

  CampusesBloc({@required this.campusesRepository})
      : assert(campusesRepository != null),
        super(CampusesInitial());

  @override
  Stream<CampusesState> mapEventToState(
    CampusesEvent event,
  ) async* {
    try {
      final List campuses = await campusesRepository.getData();
      yield CampusesLoadSuccess(campuses: campuses);
    } catch (_) {}
  }
}
