/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Currency;
import java.util.Date;
import java.util.Locale;

/**
 * @author Yoshimi
 *
 */
public class FormatUtils {
	public static String formatDate(Date date, String pattern, Locale locale) {
		DateFormat formatter = new SimpleDateFormat(pattern, locale);
		return formatter.format(date);
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
		return format.format(amount.doubleValue());
	}
}
