/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import java.io.Serializable;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * @author Yoshimi
 * 
 */
public class MailUtils implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    public final static class MailPasswordAuthenticator extends Authenticator {
        private final String username;
        private final String password;

        public MailPasswordAuthenticator(String username, String password) {
            this.username = username;
            this.password = password;
        }

        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username, password);
        }
    }

    public static void replace(StringBuilder stringBuilder, String str,
            String replaceWith) {
        int index = 0;
        while (stringBuilder.indexOf(str) >= 0) {
            index = stringBuilder.indexOf(str);
            stringBuilder.replace(index, index + str.length(),
                    replaceWith == null ? "" : replaceWith);
        }
    }

    public static void replaceLoop(StringBuilder sb, String loopName,
            int loopCount) {
        int from = 0;
        int to = 0;
        int from2 = 0;
        int to2 = 0;
        char varStart = 0;
        String loopNameString = null;
        String loopString = null;
        String countString = null;
        loopNameString = ":" + loopName + ":";
        countString = ":loopCount:";
        // find the first start loop mark
        from = sb.indexOf(loopNameString);
        while (from >= 0) {
            // remove start loop mark
            sb.delete(from, from + loopNameString.length());
            to = sb.indexOf(loopNameString);
            // remove end loop mark
            sb.delete(to, to + loopNameString.length());
            // find a variable in the loop
            from2 = sb.indexOf(":", from);
            while (from2 < to) {
                varStart = sb.charAt(from2 + 1);
                if ((varStart >= 'A' && varStart <= 'Z')
                        || (varStart >= 'a' && varStart <= 'z')
                        || (varStart >= '0' && varStart <= '9')
                        || varStart == '_') {
                    to2 = sb.indexOf(":", from2 + 1);
                    sb.insert(to2, countString);
                    to2 += countString.length();
                    to += countString.length();
                } else {
                    to2 = from2;
                }
                from2 = sb.indexOf(":", to2 + 1);
            }
            loopString = sb.substring(from, to);
            sb.delete(from, to);
            for (int i = loopCount; i > 0; i--) {
                sb.insert(from, loopString);
                replace(sb, countString, "_" + Integer.toString(i));
            }
            // find the next start loop mark
            from = sb.indexOf(loopNameString);
        }
    }

}
