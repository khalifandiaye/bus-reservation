package vn.edu.fpt.capstone.busReservation.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

public class DateUtils {
    public static long getAbsoluteMiliseconds(Date date) {
        Calendar c = Calendar.getInstance();
        c.clear();
        return date.getTime() - c.getTimeInMillis();
    }

    public static String formatDate(Date date, String pattern, Locale locale,
            TimeZone timeZone) {
        DateFormat formatter = new SimpleDateFormat(pattern, locale);
        formatter.setTimeZone(timeZone);
        return formatter.format(date);
    }

    public static Date deFormatDate(String date, String pattern, Locale locale,
            TimeZone timeZone) throws ParseException {
        DateFormat formatter = new SimpleDateFormat(pattern, locale);
        Date result = formatter.parse(date);
        long milisec = result.getTime();
        result = new Date(milisec + TimeZone.getDefault().getOffset(milisec)
                - timeZone.getOffset(milisec));
        return result;
    }
}
