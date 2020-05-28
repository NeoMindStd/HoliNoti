import 'package:holinoti_admin/constants/nos.dart' as Nos;
import 'package:sprintf/sprintf.dart';

class ApiKeys {
  // TODO: Holiday Notifier Rest API Key
  // TODO: Map View Rest API Key
}

class Preferences {
  static const IS_AUTO_LOGIN_MODE = "isAutoLoginMode";
  static const ACCOUNT = "account";
  static const PASSWORD = "password";
}

class HttpApis {
  static const SITE_URL = "http://holinoti.tk:8080";
  static const API_ROOT = "/holinoti";
  static const FACILITIES = "/facilities";
  static String facilityByCodeURI(int facilityCode) =>
      sprintf("%s%s%s/code=%d", [SITE_URL, API_ROOT, FACILITIES, facilityCode]);
  static String facilityByPHURI(String phoneNumber) => sprintf(
      "%s%s%s/phone_number=%s", [SITE_URL, API_ROOT, FACILITIES, phoneNumber]);

  static const FACILITY_IMAGES = "/facility_images";
  static String fIMGByIdURI(int facilityImageId) => sprintf("%s%s%s%s/id=%d",
      [SITE_URL, API_ROOT, FACILITIES, FACILITY_IMAGES, facilityImageId]);
  static String fIMGsByFCodeURI(int facilityCode) => sprintf(
      "%s%s%s%s/facility_code=%d",
      [SITE_URL, API_ROOT, FACILITIES, FACILITY_IMAGES, facilityCode]);

  static const OPENING_INFO = "/opening-infos";
  static String oiByIdURI(int openingInfoId) => sprintf(
      "%s%s%s/id=%d", [SITE_URL, API_ROOT, OPENING_INFO, openingInfoId]);
  static String oisByFCodeURI(int facilityCode) => sprintf(
      "%s%s%s/facility_code=%d",
      [SITE_URL, API_ROOT, OPENING_INFO, facilityCode]);

  static const RELATION_AFS = "/relation_afs";
  static String relationAFURI() =>
      sprintf("%s%s%s", [SITE_URL, API_ROOT, RELATION_AFS]);
  static String relationAFByIdURI(int relationAFId) =>
      sprintf("%s%s%s/id=%d", [SITE_URL, API_ROOT, RELATION_AFS, relationAFId]);
  static String relationAFsByFCodeURI(int facilityCode) => sprintf(
      "%s%s%s/facility_code=%d",
      [SITE_URL, API_ROOT, RELATION_AFS, facilityCode]);
  static String relationAFsByUIdURI(int userId) =>
      sprintf("%s%s%s/user_id=%d", [SITE_URL, API_ROOT, RELATION_AFS, userId]);

  static const USERS = "/users";
  static const String LOGIN_URI = "$SITE_URL$API_ROOT$USERS/login";
  static const String REGISTER_URI = "$SITE_URL$API_ROOT$USERS/register";
  static String userByAccURI(String userAccount) =>
      sprintf("%s%s%s/account=%s", [SITE_URL, API_ROOT, USERS, userAccount]);
  static String userByEmailURI(String email) =>
      sprintf("%s%s%s/email=%s", [SITE_URL, API_ROOT, USERS, email]);
  static String userByPHURI(String phoneNumber) => sprintf(
      "%s%s%s/phone_number=%s", [SITE_URL, API_ROOT, USERS, phoneNumber]);
  static String userByIdURI(int userId) =>
      sprintf("%s%s%s/id=%d", [SITE_URL, API_ROOT, USERS, userId]);

  static const String PRIVACY_POLICIES =
      "$SITE_URL$API_ROOT/privacy_policies.html";
  static const String OPEN_SRC_LICENSES =
      "$SITE_URL$API_ROOT/open_src_licenses.html";

  static const HEADER_NAME_CONTENT_TYPE = "Content-Type";
  static const HEADER_VALUE_CONTENT_TYPE = "application/json; charset=utf-8";
}

class Assets {
  static const ROOT_PATH = "assets/";
  static const RESTAURANT_JPG = ROOT_PATH + "restaurant.jpg";
  static const TEMP_IMAGE_S = ROOT_PATH + "tempimageS.jpg";
  static const TEMP_IMAGE_M = ROOT_PATH + "tempimageM.jpg";
  static const TEMP_IMAGE_L = ROOT_PATH + "tempimageL.jpg";
}

class GlobalPage {
  static const APP_NAME = "HolidayNotifier";
  static const APP_NAME_KR = "휴일 알리미";
  static const LOGIN = "로그인";
  static const REGISTER = "회원 가입";
  static const NAME = "이름";
  static const EMAIL = "이메일";
  static const PHONE_NUMBER = "전화번호";
  static const ALERT_TITLE = '안내';
  static const ALERT_INPUT = '입력';
  static const BUTTON_CONFIRM = '확인';
  static const BUTTON_YES = '네';
  static const BUTTON_NO = '아니오';
  static const BUTTON_SUBMIT = '확인';
  static const BUTTON_CANCEL = '취소';
  static const AUTO_LOGIN = '자동 로그인';
  static const BIO_AUTH_SIGN_IN_TITLE = '생체 인증';
  static const BIO_AUTH_GOTO_SETTING = '설정';
  static const BIO_AUTH_GOTO_SETTING_DESCRIPTION = '생체 인증을 설정해주세요.';
  static const BIO_AUTH_LOCALIZED_REASON = '계속 진행하시려면 인증해주십시오';
}

class HomePage {
  static const FACILITY_LIST = "시설 목록";
  static const RESISTER_FACILITY = "시설 등록";
  static const REGISTER_TEMP_HOLIDAY = "임시 휴일 등록";
}

class AuthPage {
  static const ACCOUNT = "계정";
  static const PASSWORD = "비밀번호";
  static const FORGOT_YOUR_PASSWORD = "비밀번호를 잊으셨나요?";
  static const DO_YOU_HAVE_NOT_AN_ACCOUNT = "계정이 없으신가요?";
  static const ALREADY_HAVE_YOU_AN_ACCOUNT = "계정이 이미 있으신가요?";
  static const PROHIBITED_CHARACTERS = [
    "!",
    "@",
    "#",
    "\$",
    "&",
    "*",
    "~",
  ];
  static const PASSWORD_CONDITION =
      "비밀번호는 영문자와 숫자, 특수문자(%s)를 사용 가능하며, 영문자, 숫자, 특수문자 중 2가지 이상이 조합된 %d자 이상 %d자 이하의 문장이어야 합니다.";
  static const TERMS_AND_CONDITION = "이용 약관";
  static const ERROR_TO_SHORT = "너무 짧습니다.";
  static const ERROR_TO_LONG = "너무 깁니다.";
  static const ERROR_PROHIBITED_CHARACTERS = "%s 는 사용하실 수 없습니다.";
  static const ERROR_REQUIRE_COMBINE = "영문자, 숫자, 특수문자 중 2가지 이상을 사용해야 합니다.";
  static const ERROR_WRONG_ACCOUNT = "아이디 또는 비밀번호가 잘못되었습니다.";

  static String get passwordCondition => sprintf(AuthPage.PASSWORD_CONDITION, [
        AuthPage.PROHIBITED_CHARACTERS
            .toString()
            .substring(1, AuthPage.PROHIBITED_CHARACTERS.toString().length - 1),
        Nos.AuthPage.MIN_NO_OF_CHARACTERS,
        Nos.AuthPage.MAX_NO_OF_CHARACTERS,
      ]);
}

class RegisterFacilityPage {
  static const DAYS_OF_THE_WEEKS = ['일', '월', '화', '수', '목', '금', '토'];
}

class ProfilePage {
  static const PERSONAL_INFO = "개인 정보";
  static const VERIFY_OWNER_AND_REGISTER_NEW_FACILITIES = "사업자 인증 및 신규 시설 등록";
  static const CHANGE_PROFILE_IMG = "프로필 이미지 변경";
  static const CHANGE_EMAIL = "이메일 변경";
  static const CHANGE_PHONE_NUMBER = "연락처 변경";
  static const CHANGE_PASSWORD = "비밀번호 변경";
  static const CHANGE_FINGERPRINT = "지문 변경";
  static const SET_DISCLOSURE_SCOPE_PERSONAL_INFO = "개인정보 공개 범위 설정";
  static const USER_SECESSION = "회원 탈퇴";
  static const LOGOUT = "로그아웃";
}

class SettingPage {
  static const SETTINGS = "설정";
  static const APP_SETTING = "앱 설정";
  static const ALARM_SETTING = "알림 설정";
  static const SLEEP_TIME_SETTING = "방해금지 시간대 설정";
  static const PASSWORD_FINGERPRINT_LOCK = "암호 / 지문 장금";
  static const APP_INFO = "앱 정보";
  static const BUILD_VER = "빌드 버전";
  static const COMMUNITY_RULE = "커뮤니티 이용규칙";
  static const PRIVACY_POLICIES = "개인정보 처리방침";
  static const OPEN_SRC_LICENSES = "오픈소스 라이선스";
  static const ETC = "기타";
  static const NOTICE = "공지사항";
  static const CONTACT = "문의하기";
}

class NoticePage {
  static const NOTICE_TITLE = "공지 목록";
}
