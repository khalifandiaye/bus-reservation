package vn.edu.fpt.capstone.busReservation.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
    public static long getAbsoluteMiliseconds(long time) {
        return time + TimeZone.getDefault().getOffset(time);
    }

    public static long getTime(String time) {
        String[] part = time.split(":");
        return getTime(Integer.parseInt(part[0]), Integer.parseInt(part[1]),
                Integer.parseInt(part[2]));
    }

    public static long getTime(int hour, int minute, int second) {
        return ((long) (hour * 60 + minute) * 60 + second) * 1000;
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
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, locale);
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