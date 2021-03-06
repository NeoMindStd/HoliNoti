import 'package:holinoti_customer/constants/nos.dart' as Nos;
import 'package:sprintf/sprintf.dart';

class Preferences {
  static const IS_AUTO_LOGIN_MODE = "isAutoLoginMode";
  static const ACCOUNT = "account";
  static const PASSWORD = "password";
  static const SHOW_TUTORIAL = "showTutorial";
}

class HttpApis {
  static const API_KEY_KAKAO_MAP = "2fb1a28ebf058dac66ff29d555e364e5";
  static const API_KEY_KAKAO_MAP_QUERY = "KakaoAK " + API_KEY_KAKAO_MAP;
  static const API_KEY_FCM_SERVER =
      'AAAAHmLOi9s:APA91bFvXcg0LzYrp4tCYA6zdTDdGVZ3Tqbx0i0tAuKlQEN3fsAGPXnbO_B5SBH2JMAtmHVjetHJom6x2FcAddi_ZWuv4fvbAbyqCyBosOSPYd3VCvMPp6dPCJ_CjVJHEGAxhX2s-sKq';
  static const API_AUTHORIZATION = "Authorization";
  static const HEADER_NAME_CONTENT_TYPE = "Content-Type";
  static const HEADER_VALUE_CONTENT_TYPE_JSON =
      "application/json; charset=utf-8";
  static const HEADER_VALUE_CONTENT_TYPE_URLENCODED =
      "application/x-www-form-urlencoded";

  static const SITE_URL = "http://holinoti.tk:8080";
  static const API_ROOT = "/holinoti";

  static const FACILITIES = "/facilities";
  static String facilitiesURI() =>
      sprintf("%s%s%s", [SITE_URL, API_ROOT, FACILITIES]);
  static String facilityByCodeURI(int facilityCode) =>
      sprintf("%s%s%s/code=%d", [SITE_URL, API_ROOT, FACILITIES, facilityCode]);
  static String facilityByPHURI(String phoneNumber) => sprintf(
      "%s%s%s/phone_number=%s", [SITE_URL, API_ROOT, FACILITIES, phoneNumber]);
  static String facilitiesByName(String name) =>
      sprintf("%s%s%s/name=%s", [SITE_URL, API_ROOT, FACILITIES, name]);
  static String facilitiesByCoordinates(double x, double y, int distance) =>
      sprintf("%s%s%s/x=%f/y=%f/distance_m=%d",
          [SITE_URL, API_ROOT, FACILITIES, x, y, distance]);
  static String facilitiesByCoordinatesAndName(
          double x, double y, int distance, String name) =>
      sprintf("%s%s%s/x=%f/y=%f/distance_m=%d/name=%s",
          [SITE_URL, API_ROOT, FACILITIES, x, y, distance, name]);

  static const FACILITY_IMAGES = "/facility_images";
  static String fIMGByIdURI(int facilityImageId) => sprintf("%s%s%s%s/id=%d",
      [SITE_URL, API_ROOT, FACILITIES, FACILITY_IMAGES, facilityImageId]);
  static String fIMGsByFCodeURI(int facilityCode) => sprintf(
      "%s%s%s%s/facility_code=%d",
      [SITE_URL, API_ROOT, FACILITIES, FACILITY_IMAGES, facilityCode]);
  static String fIMGViewURI(int facilityCode, String fileName) =>
      sprintf("%s%s%s%s/%d/%s", [
        SITE_URL,
        API_ROOT,
        FACILITIES,
        FACILITY_IMAGES,
        facilityCode,
        fileName
      ]);

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
  static const String SECESSION = "/secession";
  static const String COMPARE = "/compare";
  static const String LOGIN_URI = "$SITE_URL$API_ROOT$USERS/login";
  static const String LOGOUT_URI = "$SITE_URL$API_ROOT$USERS/logout";
  static const String REGISTER_URI = "$SITE_URL$API_ROOT$USERS/register";
  static String userByAccURI(String userAccount) =>
      sprintf("%s%s%s/account=%s", [SITE_URL, API_ROOT, USERS, userAccount]);
  static String userByEmailURI(String email) =>
      sprintf("%s%s%s/email=%s", [SITE_URL, API_ROOT, USERS, email]);
  static String userByPHURI(String phoneNumber) => sprintf(
      "%s%s%s/phone_number=%s", [SITE_URL, API_ROOT, USERS, phoneNumber]);
  static String userByIdURI(int userId) =>
      sprintf("%s%s%s/id=%d", [SITE_URL, API_ROOT, USERS, userId]);
  static String userSecession(String account, String password) => sprintf(
      "%s%s%s%s/%s/%s",
      [SITE_URL, API_ROOT, USERS, SECESSION, account, password]);
  static String userCompare(String account, String password) => sprintf(
      "%s%s%s%s/%s/%s",
      [SITE_URL, API_ROOT, USERS, COMPARE, account, password]);

  static const KAKAO_MAP = "/kakao_map";
  static String kakaoMapWebViewURI(double x, double y) =>
      sprintf("%s%s%s/x=%f/y=%f", [SITE_URL, API_ROOT, KAKAO_MAP, x, y]);

  static const API_URL_KAKAO_MAP_QUERY =
      "http://dapi.kakao.com/v2/local/search/address.json";
  static const API_REQUEST_BODY_KAKAO_MAP_QUERY = "query";
  static const API_REQUEST_BODY_KAKAO_MAP_PAGE = "page";
  static const API_REQUEST_BODY_KAKAO_MAP_ADDRESS_SIZE = "AddressSize";
  static const API_RESPONSE_BODY_KAKAO_MAP_DOCUMENTS = "documents";
  static const API_RESPONSE_BODY_KAKAO_MAP_ROAD_ADDRESS = "road_address";

  static const API_URL_FCM_SERVER = "https://fcm.googleapis.com/fcm/send";

  static const String PRIVACY_POLICIES =
      "$SITE_URL$API_ROOT/privacy_policies.html";
  static const String OPEN_SRC_LICENSES =
      "$SITE_URL$API_ROOT/open_src_licenses.html";
}

class Assets {
  static const ROOT_PATH = "assets/";
  static const RESTAURANT_JPG = ROOT_PATH + "restaurant.jpg";
  static const TEMP_IMAGE_S = ROOT_PATH + "tempimageS.jpg";
  static const TEMP_IMAGE_M = ROOT_PATH + "tempimageM.jpg";
  static const TEMP_IMAGE_L = ROOT_PATH + "tempimageL.jpg";
  static const SPLASH_IMAGE = ROOT_PATH + "splash.png";
}

class GlobalPage {
  static const APP_NAME = "HolidayNotifier";
  static const APP_NAME_KR = "휴일 알리미";
  static const PASSWORD = "비밀번호";
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
  static const ADMIN = "관리자";
  static const NORMAL = "일반";
  static const OPENING_INFO = "영업 시간";
  static const OPENING_INFO_NOT_EXIST = "영업시간 정보 없음";
  static const SEARCH = "검색";
  static const GIVE_UP_ADMIN = "정말 관리자를 그만두시겠습니까?";
  static const EDIT = "수정";
  static const DELETE = "삭제";
  static const NOTICE_LIST = "공지 목록";

  static const DAYS_OF_THE_WEEKS = ['일', '월', '화', '수', '목', '금', '토'];
  static const TRUE = "true";
}

class HomePage {
  static const DISTANCE_LIST = ["500m", "1km", "5km", "10km", "전체"];
  static const HOME = "홈";
  static const FACILITY_LIST = "시설 목록";
  static const OPENING_INFO_AND_IS_OPEN = "영업여부 및 운영시간";
}

class AuthPage {
  static const ACCOUNT = "계정";
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
  static const AUTO_LOGIN_DESCRIPTION = "사용으로 설정 시 앱이 켜질 때 자동으로 로그인 합니다.";

  static const SECESSION_DIALOG_INPUT = "탈퇴를 원하시면 비밀번호를 입력해 주세요.";
  static const SECESSION_DIALOG_YES_NO = "정말로 탈퇴하시겠습니까? 탈퇴된 정보는 복구하실 수 없습니다.";
  static const SECESSION_DIALOG_FAILED = "회원 탈퇴에 실패했습니다. 비밀번호가 틀렸을 수 있습니다.";

  static const LOGOUT_DIALOG_YES_NO = "로그아웃 하시겠습니까?";
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
  static const SHOW_TUTORIAL = "튜토리얼 페이지 다시 보기";

  static const SHOW_TUTORIAL_DIALOG_YES_NO = "앱이 다시 켜질 때 튜토리얼 페이지를 보여드릴까요?";
}
