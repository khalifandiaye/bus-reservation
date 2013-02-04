/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 * 
 */
public class TestReservationDAO extends DAOTest {
    @Test
    public void testGetAll() {
        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
        List<ReservationBean> beans = reservationDAO.getAll();
        Assert.assertNotNull(beans);
    }
}
