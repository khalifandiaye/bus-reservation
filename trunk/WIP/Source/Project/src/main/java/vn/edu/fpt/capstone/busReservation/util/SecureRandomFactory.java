/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import java.security.SecureRandom;

/**
 * @author Yoshimi
 * 
 */
public final class SecureRandomFactory {
	private static SecureRandom random;

	private SecureRandomFactory() {
	}

	public static SecureRandom getRandom() {
		if (random == null) {
			random = new SecureRandom();
		}
		return random;
	}
}
