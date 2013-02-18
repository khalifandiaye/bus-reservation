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
public class ReservationDAOTest extends DAOTest {
    @Test
    public void testGetAll001() {
        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
        List<ReservationBean> beans = reservationDAO.getAll();
        Assert.assertNotNull(beans);
        Assert.assertNotEquals(0, beans.size());
        Assert.assertNotNull(beans.get(0));
        Assert.assertNotEquals(0, beans.get(0).getTrips().size());
    }
    
    @Test
    public void testGetById001() {
        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
        ReservationBean bean = reservationDAO.getById(1);
        Assert.assertNotNull(bean);
        Assert.assertNotEquals(0, bean.getSeatPositions().size());
    }
}
