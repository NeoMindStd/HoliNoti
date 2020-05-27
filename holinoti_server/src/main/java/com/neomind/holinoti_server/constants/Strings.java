package com.neomind.holinoti_server.constants;

public class Strings {
    public static class Global {
        public static final String ROLE = "ROLE_";
    }

    public static class PathString {
        public static final String REGEXP = "*/**";

        public static final String CODE_PATH = "/code=";
        public static final String CODE_PATH_REGEXP = CODE_PATH + REGEXP;

        public static final String ID_PATH = "/id=";
        public static final String ID_PATH_REGEXP = ID_PATH + REGEXP;

        public static final String USER_ID_PATH = "/user_id=";
        public static final String USER_ID_PATH_REGEXP = USER_ID_PATH + REGEXP;

        public static final String FACILITY_CODE_PATH = "/facility_code=";
        public static final String FACILITY_CODE_PATH_REGEXP = FACILITY_CODE_PATH + REGEXP;

        public static final String ACCOUNT_PATH = "/account=";
        public static final String ACCOUNT_PATH_REGEXP = ACCOUNT_PATH + REGEXP;

        public static final String EMAIL_PATH = "/email=";
        public static final String EMAIL_PATH_REGEXP = EMAIL_PATH + REGEXP;

        public static final String PHONE_NUMBER_PATH = "/phone_number=";
        public static final String PHONE_NUMBER_PATH_REGEXP = PHONE_NUMBER_PATH + REGEXP;

        public static final String X_PATH = "/x=";
        public static final String X_PATH_REGEXP = X_PATH + REGEXP;

        public static final String Y_PATH = "/y=";
        public static final String Y_PATH_REGEXP = Y_PATH + REGEXP;

        public static final String DISTANCE_PATH = "/distance_m=";
        public static final String DISTANCE_PATH_REGEXP = DISTANCE_PATH + REGEXP;

        /// Facility
        public static final String FACILITIES = "/facilities";
        public static final String FACILITIES_URL = FACILITIES + "/**";
        public static final String FACILITIES_URL_BY_CODE = FACILITIES + CODE_PATH_REGEXP;
        public static final String FACILITIES_URL_BY_PHONE_NUMBER = FACILITIES + PHONE_NUMBER_PATH_REGEXP;
        public static final String FACILITIES_URL_BY_DISTANCE = FACILITIES + X_PATH + "*" + Y_PATH + "*" + DISTANCE_PATH_REGEXP;

        /// FacilityImage
        public static final String FACILITIES_IMAGES = "/facility_images";
        public static final String FACILITIES_IMAGES_FULL_PATH = FACILITIES + FACILITIES_IMAGES; //path
        public static final String FACILITIES_IMAGES_URL = FACILITIES_IMAGES_FULL_PATH + "/**";
        public static final String FACILITIES_IMAGES_URL_BY_ID = FACILITIES_IMAGES_FULL_PATH + ID_PATH_REGEXP;
        public static final String FACILITIES_IMAGES_URL_BY_FACILITY_CODE = FACILITIES_IMAGES_FULL_PATH + FACILITY_CODE_PATH_REGEXP;

        /// RelationAF
        public static final String RELATION_AFS = "/relation_afs";
        public static final String RELATION_AFS_URL = RELATION_AFS + "/**";
        public static final String RELATION_AFS_URL_BY_ID = RELATION_AFS + ID_PATH_REGEXP;
        public static final String RELATION_AFS_URL_BY_USER_ID = RELATION_AFS + USER_ID_PATH_REGEXP;
        public static final String RELATION_AFS_URL_BY_FACILITY_CODE = RELATION_AFS + FACILITY_CODE_PATH_REGEXP;

        /// User
        public static final String USER = "/users";
        public static final String USER_URL = USER + "/**";
        public static final String USER_URL_BY_ACCOUNT = USER + ACCOUNT_PATH_REGEXP;
        public static final String USER_URL_BY_EMAIL = USER + EMAIL_PATH_REGEXP;
        public static final String USER_URL_BY_PHONE_NUMBER = USER + PHONE_NUMBER_PATH_REGEXP;
        public static final String USER_URL_BY_ID = USER + ID_PATH_REGEXP;
        public static final String LOGIN_PATH = "/login";
        public static final String REGISTER_PATH = "/register";
        public static final String USER_LOGIN_URL = USER + LOGIN_PATH + "/**";
        public static final String USER_REGISTER_URL = USER + REGISTER_PATH + "/**";

        /// View
        public static final String KAKAO_MAP_VIEW = "kakao_map";
        public static final String KAKAO_MAP = "/" + KAKAO_MAP_VIEW;

    }
}

