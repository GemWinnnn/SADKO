import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/organizations/organizations_repository.dart';

part 'organizations_event.dart';
part 'organizations_state.dart';

class OrganizationsInitial extends OrganizationsState {}

class OrganizationsLoadInProgress extends OrganizationsState {}

class OrganizationsLoadSuccess extends OrganizationsState {
  final List<Organizations> organizations;

  const OrganizationsLoadSuccess({@required this.organizations})
      : assert(organizations != null);

  @override
  List<Object> get props => [organizations];
}

class OrganizationsLoadFailure extends OrganizationsState {}

class OrganizationsBloc extends Bloc<OrganizationsEvent, OrganizationsState> {
  final OrganizationsRepository organizationsRepository;

  OrganizationsBloc({@required this.organizationsRepository})
      : assert(organizationsRepository != null),
        super(OrganizationsInitial());

  @override
  Stream<OrganizationsState> mapEventToState(
    OrganizationsEvent event,
  ) async* {
    try {
      final List organizations = await organizationsRepository.getData();
      yield OrganizationsLoadSuccess(organizations: organizations);
    } catch (_) {}
  }
}
