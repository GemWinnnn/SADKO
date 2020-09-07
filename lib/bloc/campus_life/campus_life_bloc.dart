import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/campus_life/campus_life_repository.dart';

part 'campus_life_event.dart';
part 'campus_life_state.dart';

class CampusLifeInitial extends CampusLifeState {}

class CampusLifeLoadInProgress extends CampusLifeState {}

class CampusLifeLoadSuccess extends CampusLifeState {
  final List<CampusLife> campus_life;

  const CampusLifeLoadSuccess({@required this.campus_life})
      : assert(campus_life != null);

  @override
  List<Object> get props => [campus_life];
}

class CampusLifeLoadFailure extends CampusLifeState {}

class CampusLifeBloc extends Bloc<CampusLifeEvent, CampusLifeState> {
  final CampusLifeRepository campusLifeRepository;

  CampusLifeBloc({@required this.campusLifeRepository})
      : assert(campusLifeRepository != null),
        super(CampusLifeInitial());

  @override
  Stream<CampusLifeState> mapEventToState(
    CampusLifeEvent event,
  ) async* {
    try {
      final List campus_life = await campusLifeRepository.getData();
      yield CampusLifeLoadSuccess(campus_life: campus_life);
    } catch (_) {}
  }
}
