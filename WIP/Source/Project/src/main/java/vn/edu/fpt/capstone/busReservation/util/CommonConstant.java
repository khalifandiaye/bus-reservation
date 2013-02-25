package vn.edu.fpt.capstone.busReservation.util;

import java.util.Locale;
import java.util.TimeZone;

public interface CommonConstant {
    /**
     * Vietnam Locale
     */
    public final static Locale LOCALE_VN = new Locale("vi", "VN");
    /**
     * US Locale
     */
    public final static Locale LOCALE_US = Locale.US;
    /**
     * Max number of retries when generating reservation code
     */
    public final static int MAX_REGENERATE_CODE_TRY = 3;
    /**
     * <b>Class<b> {@link vn.edu.fpt.capstone.busReservation.displayModel.User}
     */
    public final static String SESSION_KEY_USER = "user";
    /**
     * <b>Class<b> {@link java.lang.String}
     */
    public final static String SESSION_KEY_PAYMENT_METHOD_ID = "paymentMethodId";
    /**
     * <b>Class<b> {@link java.lang.String}
     */
    public final static String SESSION_KEY_RESERVATION_ID = "reservationId";
    /**
     * <b>Class<b> {@link java.lang.String}
     */
    public final static String SESSION_KEY_PAYMENT_TOKEN = "paymentToken";
    /**
     * In minutes
     */
    public final static int RESERVATION_TIMEOUT = 15;
    /**
     * The number of days before departure time that a reservation status
     * changes from paid to pending
     */
    public final static int RESERVATION_LOCK = 7;
    /**
     * The first refund rate in percentage
     */
    public final static int REFUND_RATE_1 = 80;
    /**
     * The The minimum number of days before departure time for the first refund
     * rate to be applied
     */
    public final static int REFUND_TIME_LIMIT_1 = 20;
    /**
     * The second refund rate in percentage
     */
    public final static int REFUND_RATE_2 = 50;
    /**
     * The The minimum number of days before departure time for the second
     * refund rate to be applied
     */
    public final static int REFUND_TIME_LIMIT_2 = 10;
    /**
     * GMT+07
     */
    public final static TimeZone DEFAULT_TIME_ZONE = TimeZone
            .getTimeZone("Asia/Ho_Chi_Minh");
    /**
     * GMT
     */
    public final static TimeZone UTC_TIME_ZONE = TimeZone.getTimeZone("GMT");
}
