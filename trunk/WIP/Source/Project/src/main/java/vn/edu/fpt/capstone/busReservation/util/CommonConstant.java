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
     * <b>Class<b> {@link java.lang.Integer}
     */
    public final static String SESSION_KEY_PAYMENT_METHOD_ID = "paymentMethodId";
    /**
     * <b>Class<b> {@link java.lang.Integer}
     */
    public final static String SESSION_KEY_PAYMENT_TOKEN = "paymentToken";
    /**
     * <b>Class<b> {@link java.lang.Integer}
     */
    public final static String SESSION_KEY_RESERVATION_ID = "reservationId";
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

    /**
     * Ticket type: One way
     */
    public final static String TICKET_ONE_WAY = "oneway";

    /**
     * Ticket type: Round trip
     */
    public final static String TICKET_ROUND_TRIP = "roundtrip";
    
    /**
     * Min time to book a ticket before the bus is departed
     */
    public final static int MIN_TIME_BEFORE_DEPART = 30;

    /**
     * http prefix
     */
    // TODO remove localhost:8080 when deploy on real server
    public final static String URL_HTTP = "http://localhost:8080";
    /**
     * https prefix
     */
    // TODO remove localhost:8443 when deploy on real server
    public final static String URL_HTTPS = "https://localhost:8443";
    public final static String PATTERN_DATE_TIME_FULL = "EEEEE dd/MM/yyyy kk:mm";
    public final static String PATTERN_DATE_TIME_LONG = "dd/MM/yyyy kk:mm";
    /**
     * Switch to enable/disable debug mode
     */
    public final static boolean DEBUG_MODE = true;
    /**
     * Minimum number of passenger for each trip
     */
    public final static int PASSENGER_MIN_NO = 1;
}
