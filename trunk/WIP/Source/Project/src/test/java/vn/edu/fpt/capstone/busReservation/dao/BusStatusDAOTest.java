/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 *
 */
public class BusStatusDAOTest extends DAOTest {
    @Test
    public void testGetAll001() {
        BusStatusDAO busStatusDAO = (BusStatusDAO) getBean("busStatusDAO");
        List<BusStatusBean> beans = busStatusDAO.getAll();
        Assert.assertNotNull(beans);
        Assert.assertNotEquals(0, beans.size());
        Assert.assertNotNull(beans.get(0));
        Assert.assertNotEquals(0, beans.get(0).getTrips().size());
    }
}
