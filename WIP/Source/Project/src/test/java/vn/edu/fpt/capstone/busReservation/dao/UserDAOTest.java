/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import org.junit.Assert;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 *
 */
public class UserDAOTest extends DAOTest {
    @Test
    public void testIsExist001() {
        UserDAO userDAO = (UserDAO) getBean("userDAO");
        boolean result = userDAO.isExist("sonngocs");
        Assert.assertFalse(result);
    }
}
