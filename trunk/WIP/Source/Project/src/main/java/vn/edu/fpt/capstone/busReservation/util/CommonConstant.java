package vn.edu.fpt.capstone.busReservation.util;

import java.util.Locale;
import java.util.TimeZone;

public interface CommonConstant {
    public final static Locale LOCALE_VN = new Locale("vi", "VN");
    public final static Locale LOCALE_US = Locale.US;
    public final static int MAX_REGENERATE_CODE_TRY = 3;
    /**
     * <b>Class<b> {@link vn.edu.fpt.capstone.busReservation.displayModel.User}
     */
    public final static String SESSION_KEY_USER = "user";
    public final static String SESSION_KEY_RESERVATION_ID = "reservationId";
    public final static String SESSION_KEY_PAYMENT_TOKEN = "paymentToken";
    /**
     * In minutes
     */
    public final static int RESERVATION_TIMEOUT = 15;
    public final static TimeZone DEFAULT_TIME_ZONE = TimeZone.getTimeZone("Asia/Ho_Chi_Minh");
    public final static TimeZone UTC_TIME_ZONE = TimeZone.getTimeZone("GMT");
}
