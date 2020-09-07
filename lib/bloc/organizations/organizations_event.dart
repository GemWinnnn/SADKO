part of 'organizations_bloc.dart';

@immutable
abstract class OrganizationsEvent {
  const OrganizationsEvent();
}

class OrganizationsRequested extends OrganizationsEvent {
  const OrganizationsRequested();

  @override
  List<Object> get props => [];
}
