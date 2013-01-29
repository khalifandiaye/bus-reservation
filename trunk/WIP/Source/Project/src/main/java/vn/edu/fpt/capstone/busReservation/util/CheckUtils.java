/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

/**
 * @author Yoshimi
 * 
 */
public abstract class CheckUtils {
	/**
	 * Check if a string is null or blank
	 * 
	 * @param string
	 *            the string to be checked
	 * @return true if string is null or blank, false otherwise
	 * @author Yoshimi
	 */
	public static boolean isNullOrBlank(String string) {
		return string == null || string.isEmpty();
	}

	/**
	 * Check if a string is null, empty, or represent a positive or negative
	 * whole number<br>
	 * NOTE: only Latin digits allowed
	 * 
	 * @param string
	 *            the string to be checked
	 * @return true if string is null, empty, or represent a positive or
	 *         negative whole number, false otherwise
	 * @author Yoshimi
	 */
	public static boolean isInteger(String string) {
		return isNullOrBlank(string) || string.matches("-?\\d+");
	}

	/**
	 * Check if a string is null, empty, or represent a positive whole number<br>
	 * NOTE: only Latin digits allowed
	 * 
	 * @param string
	 *            the string to be checked
	 * @return true if string is null, empty, or represent a positive whole
	 *         number, false otherwise
	 * @author Yoshimi
	 */
	public static boolean isPositiveInteger(String string) {
		return isNullOrBlank(string) || string.matches("\\d+");
	}

	/**
	 * Check if a string is null, empty, or represent a negative whole number<br>
	 * NOTE: only Latin digits allowed
	 * 
	 * @param string
	 *            the string to be checked
	 * @return true if string is null, empty, or represent a negative whole
	 *         number, false otherwise
	 * @author Yoshimi
	 */
	public static boolean isNegativeInteger(String string) {
		return isNullOrBlank(string) || string.matches("-\\d+");
	}

	/**
	 * Check if a string is null, empty, or represent a positive or negative
	 * float-point number<br>
	 * NOTE: only Latin digits allowed
	 * 
	 * @param string
	 *            the string to be checked
	 * @return true if string is null, empty, or represent a positive or
	 *         negative float-point number, false otherwise
	 * @author Yoshimi
	 */
	public static boolean isRealNumber(String string) {
		return isNullOrBlank(string) || string.matches("-?\\d+(\\.\\d+)?");
	}

	/**
	 * Check if a string is null, empty, or represent a positive float-point
	 * number<br>
	 * NOTE: only Latin digits allowed
	 * 
	 * @param string
	 *            the string to be checked
	 * @return true if string is null, empty, or represent a positive
	 *         float-point number, false otherwise
	 * @author Yoshimi
	 */
	public static boolean isPositiveRealNumber(String string) {
		return isNullOrBlank(string) || string.matches("\\d+(\\.\\d+)?");
	}

	/**
	 * Check if a string is null, empty, or represent a negative float-point
	 * number<br>
	 * NOTE: only Latin digits allowed
	 * 
	 * @param string
	 *            the string to be checked
	 * @return true if string is null, empty, or represent a negative
	 *         float-point number, false otherwise
	 * @author Yoshimi
	 */
	public static boolean isNegativeRealNumber(String string) {
		return isNullOrBlank(string) || string.matches("-\\d+(\\.\\d+)?");
	}
}
