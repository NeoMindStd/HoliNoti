import 'package:holinoti_admin/data/facility.dart';
import 'package:rxdart/rxdart.dart';

class FacilityBloc {
  Facility facility;
  bool _updateMode;

  final _facilitySubject = PublishSubject<Facility>();
  final _updateModeSubject = PublishSubject<bool>();

  FacilityBloc(this.facility) {
    _updateMode = false;
  }

  get isUpdateMode => _updateMode;
  get facilityStream => _facilitySubject.stream;
  get updateModeStream => _updateModeSubject.stream;

  set updateMode(bool isUpdateMode) {
    this._updateMode = isUpdateMode;
    _updateModeSubject.add(isUpdateMode);
  }

  set setFacility(Facility facility) {
    this.facility = facility;
    _facilitySubject.add(facility);
  }

  void dispose() {
    _facilitySubject.close();
    _updateModeSubject.close();
  }
}
