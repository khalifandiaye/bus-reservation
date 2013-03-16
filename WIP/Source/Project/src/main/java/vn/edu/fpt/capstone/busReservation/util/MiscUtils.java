/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import java.io.Serializable;

/**
 * @author Yoshimi
 *
 */
public class MiscUtils implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    
    public static void replace(StringBuilder stringBuilder, String str, String replaceWith) {
        int index = 0;
        index = stringBuilder.indexOf(str);
        stringBuilder.replace(index, index + str.length(), replaceWith);
    }

}
