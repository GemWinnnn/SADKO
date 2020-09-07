import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/models/facilities_amenities.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/repositories/facilities_amenities/facilities_amenities_repository.dart';

part 'facilities_amenities_event.dart';
part 'facilities_amenities_state.dart';

class FacilitiesAmenitiesInitial extends FacilitiesAmenitiesState {}

class FacilitiesAmenitiesLoadInProgress extends FacilitiesAmenitiesState {}

class FacilitiesAmenitiesLoadSuccess extends FacilitiesAmenitiesState {
  final List<FacilitiesAmenities> facilitiesAmenities;

  const FacilitiesAmenitiesLoadSuccess({@required this.facilitiesAmenities})
      : assert(facilitiesAmenities != null);

  @override
  List<Object> get props => [facilitiesAmenities];
}

class FacilitiesAmenitiesLoadFailure extends FacilitiesAmenitiesState {}

class FacilitiesAmenitiesBloc
    extends Bloc<FacilitiesAmenitiesEvent, FacilitiesAmenitiesState> {
  final FacilitiesAmenitiesRepository facilitiesAmenitiesRepository;

  FacilitiesAmenitiesBloc({@required this.facilitiesAmenitiesRepository})
      : assert(facilitiesAmenitiesRepository != null),
        super(FacilitiesAmenitiesInitial());

  @override
  Stream<FacilitiesAmenitiesState> mapEventToState(
    FacilitiesAmenitiesEvent event,
  ) async* {
    try {
      final List facilitiesAmenities =
          await facilitiesAmenitiesRepository.getData();
      yield FacilitiesAmenitiesLoadSuccess(
          facilitiesAmenities: facilitiesAmenities);
    } catch (_) {}
  }
}
