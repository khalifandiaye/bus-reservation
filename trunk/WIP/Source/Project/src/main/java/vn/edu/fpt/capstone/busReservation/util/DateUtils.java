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
    public static String date2String(final Date date, String pattern, Locale locale,
            TimeZone timeZone) {
    	long offset = 0;
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, locale);
//        formatter.setTimeZone(timeZone);
        offset = timeZone.getOffset(date.getTime());
        return formatter.format(new Date(date.getTime() + offset));
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
    
	/**
	 * Add days in string format
	 * 
	 * @param inputDate
	 * 			The date that needs to add
	 * @param amount
	 *  		The amount of days to be added
	 * @param pattern
	 * 			The pattern describing date format (ex: dd-MM-yyyy, yyyy/MM/dd,...)
	 * @param locale
	 * 			The locale whose date format symbol should be used
	 * @return
	 * 			The day that has been added in string (formatted in input pattern)
	 */
	public static String addDay(String inputDate, int amount, String pattern, Locale locale) 
			throws ParseException {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, locale);
		cal.setTime(formatter.parse(inputDate));
		cal.add(Calendar.DAY_OF_MONTH, amount);
		return formatter.format(cal.getTime());
	}
	
	public static boolean isDateEqual(final Date date1, final Date date2) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd", Locale.US);
		if(formatter.format(date1) == formatter.format(date2)){
			return true;
		}
		return false;
	}
	
	/**
	 * Get MM-dd String from Date
	 * @param inputDate 
	 * 			the date to get String 
	 * @return
	 * 			MM-dd String
	 */
	public static String getMonthDay(final Date inputDate) {
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM", Locale.US);
		return formatter.format(inputDate);
	}
}
