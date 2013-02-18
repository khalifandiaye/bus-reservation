/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import org.junit.Assert;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionKey;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 * 
 */
public class SeatPositionDAOTest extends DAOTest {
    @Test
    public void testGetById001() {
        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
        ReservationBean reservationBean = reservationDAO.getById(1);
        SeatPositionDAO seatPositionDAO = (SeatPositionDAO) getBean("seatPositionDAO");
        SeatPositionKey key = new SeatPositionKey();
        key.setName("A1");
        key.setReservation(reservationBean);
        SeatPositionBean bean = seatPositionDAO.getById(key);
        Assert.assertNotNull(bean);
    }
}
