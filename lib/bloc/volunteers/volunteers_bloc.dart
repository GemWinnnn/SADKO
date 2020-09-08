import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/volunteers/volunteers_repository.dart';

part 'volunteers_event.dart';
part 'volunteers_state.dart';

class VolunteersInitial extends VolunteersState {}

class VolunteersLoadInProgress extends VolunteersState {}

class VolunteersLoadSuccess extends VolunteersState {
  final List<Volunteers> volunteers;

  const VolunteersLoadSuccess({@required this.volunteers})
      : assert(volunteers != null);

  @override
  List<Object> get props => [volunteers];
}

class VolunteersLoadFailure extends VolunteersState {}

class VolunteersBloc extends Bloc<VolunteersEvent, VolunteersState> {
  final VolunteersRepository volunteersRepository;

  VolunteersBloc({@required this.volunteersRepository})
      : assert(volunteersRepository != null),
        super(VolunteersInitial());

  @override
  Stream<VolunteersState> mapEventToState(
    VolunteersEvent event,
  ) async* {
    try {
      final List volunteers = await volunteersRepository.getData();
      yield VolunteersLoadSuccess(volunteers: volunteers);
    } catch (_) {}
  }
}
