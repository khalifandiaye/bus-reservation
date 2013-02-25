package vn.edu.fpt.capstone.busReservation.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

public class DateUtils {
    /**
     * Convert the time interval represented by <tt>date</tt> to milliseconds
     * 
     * @param date
     *            a relative time interval
     * @return the number of milliseconds represented in the interval
     */
    public static long getAbsoluteMiliseconds(Date date) {
        Calendar c = Calendar.getInstance();
        c.clear();
        return date.getTime() - c.getTimeInMillis();
    }

    /**
     * Convert a date object to string
     * 
     * @param date
     *            a date object
     * @param pattern
     *            the expected pattern of the formatted string
     * @param locale
     *            the locale of the symbols used in the formatted string
     * @param timeZone
     *            time zone of the formatted string
     * @return the formatted time string
     * @throws ParseException
     */
    public static String date2String(Date date, String pattern, Locale locale,
            TimeZone timeZone) {
        DateFormat formatter = new SimpleDateFormat(pattern, locale);
        formatter.setTimeZone(timeZone);
        return formatter.format(date);
    }

    /**
     * Convert a formatted string to a date object
     * 
     * @param date
     *            a formatted time string
     * @param pattern
     *            the pattern of the formatted string
     * @param locale
     *            the locale of the symbols used in the formatted string
     * @param timeZone
     *            time zone of the formatted string
     * @return the date object represented by the string
     */
    public static Date string2Date(String date, String pattern, Locale locale,
            TimeZone timeZone) throws ParseException {
        DateFormat formatter = new SimpleDateFormat(pattern, locale);
        Date result = formatter.parse(date);
        long milisec = result.getTime();
        result = new Date(milisec + TimeZone.getDefault().getOffset(milisec)
                - timeZone.getOffset(milisec));
        return result;
    }
}
