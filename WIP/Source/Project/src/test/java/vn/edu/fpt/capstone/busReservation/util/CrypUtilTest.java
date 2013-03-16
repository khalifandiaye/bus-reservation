/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import static org.junit.Assert.*;

import java.security.NoSuchAlgorithmException;

import org.junit.Test;

/**
 * @author Yoshimi
 * 
 */
public class CrypUtilTest {
    @Test
    public void testEncrypt2String001() throws NoSuchAlgorithmException {
        String string = CryptUtils.encrypt2String("a string");
        System.out.println(string);
        assertNotNull(string);
    }

    @Test
    public void testEncrypt2String002() throws NoSuchAlgorithmException {
        String string = CryptUtils
                .encrypt2String("a very very very loooooooooooooooooooooooooooooooooooooooong string");
        System.out.println(string);
        assertNotNull(string);
    }

    @Test
    public void testEncrypt2String003() throws NoSuchAlgorithmException {
        String string1 = CryptUtils.encrypt2String("a string");
        String string2 = CryptUtils.encrypt2String("another string");
        System.out.println(string1);
        assertNotNull(string1);
        assertNotNull(string2);
        assertNotEquals(string1, string2);
    }

    @Test
    public void testEncrypt2String004() throws NoSuchAlgorithmException {
        String string1 = CryptUtils.encrypt2String("a string");
        String string2 = CryptUtils.encrypt2String("a string");
        System.out.println(string1);
        assertNotNull(string1);
        assertNotNull(string2);
        assertEquals(string1, string2);
    }
}
