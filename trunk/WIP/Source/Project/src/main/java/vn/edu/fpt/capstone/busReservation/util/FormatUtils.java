/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Currency;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

/**
 * @author Yoshimi
 *
 */
public class FormatUtils {
	public static String formatDate(Date date, String pattern, Locale locale, TimeZone timeZone) {
		DateFormat formatter = new SimpleDateFormat(pattern, locale);
		formatter.setTimeZone(timeZone);
		return formatter.format(date);
	}
    public static Date deFormatDate(String date, String pattern, Locale locale) throws ParseException {
        DateFormat formatter = new SimpleDateFormat(pattern, locale);
        return formatter.parse(date);
    }
	
	public static String formatCurrency(BigDecimal amount, int fractionDigits, String currency, Locale locale) {
		NumberFormat format = NumberFormat.getCurrencyInstance(locale);
		format.setCurrency(Currency.getInstance(currency));
		format.setMaximumFractionDigits(fractionDigits);
		format.setMinimumFractionDigits(fractionDigits);
		return format.format(amount.doubleValue());
	}
	
	public static String formatNumber(BigDecimal amount, int fractionDigits, Locale locale) {
		NumberFormat format = NumberFormat.getInstance(locale);
		format.setMaximumFractionDigits(fractionDigits);
		format.setMinimumFractionDigits(fractionDigits);
		format.setRoundingMode(RoundingMode.CEILING);
		return format.format(amount.doubleValue());
	}
    
    public static String formatNumber(double amount, int fractionDigits, Locale locale) {
        NumberFormat format = NumberFormat.getInstance(locale);
        format.setMaximumFractionDigits(fractionDigits);
        format.setMinimumFractionDigits(fractionDigits);
        format.setRoundingMode(RoundingMode.CEILING);
        return format.format(amount);
    }
	
	public static BigDecimal deformatNumber(String string, Locale locale) throws ParseException {
	    NumberFormat format = NumberFormat.getInstance(locale);
	    return BigDecimal.valueOf(format.parse(string).doubleValue());
	}
	
	public static void main(String[] args) {
	    System.out.println(Arrays.toString(TimeZone.getAvailableIDs(TimeZone.getTimeZone("Asia/Ho_Chi_Minh").getRawOffset())));
	}
}
