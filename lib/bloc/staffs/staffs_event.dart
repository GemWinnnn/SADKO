part of 'staffs_bloc.dart';

@immutable
abstract class StaffsEvent {
  const StaffsEvent();
}

class StaffsRequested extends StaffsEvent {
  const StaffsRequested();

  @override
  List<Object> get props => [];
}
