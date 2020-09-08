import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/admin_buildings/admin_buildings_repository.dart';

part 'admin_buildings_event.dart';
part 'admin_buildings_state.dart';

class AdminBuildingsInitial extends AdminBuildingsState {}

class AdminBuildingsLoadInProgress extends AdminBuildingsState {}

class AdminBuildingsLoadSuccess extends AdminBuildingsState {
  final List<AdminBuildings> admin_buildings;

  const AdminBuildingsLoadSuccess({@required this.admin_buildings})
      : assert(admin_buildings != null);

  @override
  List<Object> get props => [admin_buildings];
}

class AdminBuildingsLoadFailure extends AdminBuildingsState {}

class AdminBuildingsBloc
    extends Bloc<AdminBuildingsEvent, AdminBuildingsState> {
  final AdminBuildingsRepository adminBuildingsRepository;

  AdminBuildingsBloc({@required this.adminBuildingsRepository})
      : assert(adminBuildingsRepository != null),
        super(AdminBuildingsInitial());

  @override
  Stream<AdminBuildingsState> mapEventToState(
    AdminBuildingsEvent event,
  ) async* {
    try {
      final List adminBuildings = await adminBuildingsRepository.getData();
      yield AdminBuildingsLoadSuccess(admin_buildings: adminBuildings);
    } catch (_) {}
  }
}
