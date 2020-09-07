import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/colleges/colleges_repository.dart';

part 'colleges_event.dart';
part 'colleges_state.dart';

class CollegesInitial extends CollegesState {}

class CollegesLoadInProgress extends CollegesState {}

class CollegesLoadSuccess extends CollegesState {
  final List<Colleges> colleges;

  const CollegesLoadSuccess({@required this.colleges})
      : assert(colleges != null);

  @override
  List<Object> get props => [colleges];
}

class CollegesLoadFailure extends CollegesState {}

class CollegesBloc extends Bloc<CollegesEvent, CollegesState> {
  final CollegesRepository collegesRepository;

  CollegesBloc({@required this.collegesRepository})
      : assert(collegesRepository != null),
        super(CollegesInitial());

  @override
  Stream<CollegesState> mapEventToState(
    CollegesEvent event,
  ) async* {
    try {
      final List colleges = await collegesRepository.getData();
      yield CollegesLoadSuccess(colleges: colleges);
    } catch (_) {}
  }
}
