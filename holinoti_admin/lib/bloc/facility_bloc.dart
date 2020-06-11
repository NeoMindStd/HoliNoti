import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/notification.dart' as Data;
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class FacilityBloc {
  Facility _facility;
  bool _updateMode;
  DateTime _holidayStart;
  DateTime _holidayEnd;

  final _facilitySubject = PublishSubject<Facility>();
  final _updateModeSubject = PublishSubject<bool>();
  final _holidayStartSubject = PublishSubject<DateTime>();
  final _holidayEndSubject = PublishSubject<DateTime>();

  FacilityBloc(this._facility) {
    _updateMode = false;
    _holidayStart = DateTime.now();
    _holidayEnd = DateTime.now();
  }

  get facility => _facility;
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

  set facility(Facility facility) {
    this._facility = facility;
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

  Future submitTempHoliday(String text) async {
    Data.Notification notification = Data.Notification(
        title: "${_facility.name} 임시 휴업 알림",
        body:
            "사유: $text, 기간: ${DateFormat('yyyy-MM-dd').format(_holidayStart)} ~ ${DateFormat('yyyy-MM-dd').format(_holidayEnd)}");
    print("====Notification Request====");
    print(_facility.code);
    print(notification);
    print("==============================");
    http.Response response = await DataManager().client.post(
          Strings.HttpApis.notificationFromFCodeURI(_facility.code),
          headers: {
            Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
          },
          body: Data.notificationToJson(notification),
        );
    print("====Notification Response====");
    print(response.statusCode);
    print(response.headers);
    print(response.body);
    print("==============================");
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
