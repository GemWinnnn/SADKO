part of 'facilities_amenities_bloc.dart';

@immutable
abstract class FacilitiesAmenitiesEvent {
  const FacilitiesAmenitiesEvent();
}

class FacilitiesAmenitiesRequested extends FacilitiesAmenitiesEvent {
  const FacilitiesAmenitiesRequested();

  @override
  List<Object> get props => [];
}
