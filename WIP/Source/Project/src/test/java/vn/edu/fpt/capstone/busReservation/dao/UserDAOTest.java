/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;
import vn.edu.fpt.capstone.busReservation.util.CryptUtils;

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
    @Test
    public void testUpdate() throws NoSuchAlgorithmException {
        UserDAO userDAO = (UserDAO) getBean("userDAO");
        List<UserBean> beans = userDAO.getAll();
        for (UserBean userBean : beans) {
            if (userBean.getId() != 4) {
                userBean.setPassword(CryptUtils.encrypt2String(userBean.getPassword()));
            }
        }
        userDAO.update(beans);
    }
}
