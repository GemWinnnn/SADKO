import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/staffs/staffs_repository.dart';

part 'staffs_event.dart';
part 'staffs_state.dart';

class StaffsInitial extends StaffsState {}

class StaffsLoadInProgress extends StaffsState {}

class StaffsLoadSuccess extends StaffsState {
  final List<Staffs> staffs;

  const StaffsLoadSuccess({@required this.staffs}) : assert(staffs != null);

  @override
  List<Object> get props => [staffs];
}

class StaffsLoadFailure extends StaffsState {}

class StaffsBloc extends Bloc<StaffsEvent, StaffsState> {
  final StaffsRepository staffsRepository;

  StaffsBloc({@required this.staffsRepository})
      : assert(staffsRepository != null),
        super(StaffsInitial());

  @override
  Stream<StaffsState> mapEventToState(
    StaffsEvent event,
  ) async* {
    try {
      final List staffs = await staffsRepository.getData();
      yield StaffsLoadSuccess(staffs: staffs);
    } catch (_) {}
  }
}
