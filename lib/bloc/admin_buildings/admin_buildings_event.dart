part of 'admin_buildings_bloc.dart';

@immutable
abstract class AdminBuildingsEvent {
  const AdminBuildingsEvent();
}

class AdminBuildingsRequested extends AdminBuildingsEvent {
  const AdminBuildingsRequested();

  @override
  List<Object> get props => [];
}
