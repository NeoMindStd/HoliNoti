import 'package:holinoti_admin/data/facility.dart';
import 'package:rxdart/rxdart.dart';

class FacilityBloc {
  Facility facility;
  bool _updateMode;
  DateTime _holidayStart;
  DateTime _holidayEnd;

  final _facilitySubject = PublishSubject<Facility>();
  final _updateModeSubject = PublishSubject<bool>();
  final _holidayStartSubject = PublishSubject<DateTime>();
  final _holidayEndSubject = PublishSubject<DateTime>();

  FacilityBloc(this.facility) {
    _updateMode = false;
    _holidayStart = DateTime.now();
    _holidayEnd = DateTime.now();
  }

  get isUpdateMode => _updateMode;
  get holidayStart => _holidayStart;
  get holidayEnd => _holidayEnd;
  get facilityStream => _facilitySubject.stream;
  get updateModeStream => _updateModeSubject.stream;
  get holidayStartStream => _holidayStartSubject.stream;
  get holidayEndStream => _holidayEndSubject.stream;

  set updateMode(bool isUpdateMode) {
    this._updateMode = isUpdateMode;
    _updateModeSubject.add(isUpdateMode);
  }

  set setFacility(Facility facility) {
    this.facility = facility;
    _facilitySubject.add(facility);
  }

  set holidayStart(DateTime dateTime) {
    this._holidayStart = dateTime;
    _holidayStartSubject.add(dateTime);
  }

  set holidayEnd(DateTime dateTime) {
    this._holidayEnd = dateTime;
    _holidayEndSubject.add(dateTime);
  }

  void dispose() {
    _facilitySubject.close();
    _updateModeSubject.close();
    _holidayStartSubject.close();
    _holidayEndSubject.close();
    _holidayStart = DateTime.now();
    _holidayEnd = DateTime.now();
  }
}
