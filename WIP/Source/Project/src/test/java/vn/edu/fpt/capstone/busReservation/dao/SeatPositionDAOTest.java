/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionKey;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
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

    @Test
    public void testCheckDoubleBooking001() {
        TripDAO tripDAO = (TripDAO) getBean("tripDAO");
        List<TripBean> trips = new ArrayList<TripBean>();
        trips.add(tripDAO.getById(4));
        trips.add(tripDAO.getById(3));
        List<String> seatNames = new ArrayList<String>();
        seatNames.add("A1");
        seatNames.add("B1");
        seatNames.add("B2");
        SeatPositionDAO seatPositionDAO = (SeatPositionDAO) getBean("seatPositionDAO");
        List<String> beans = seatPositionDAO.checkDoubleBooking(trips,
                seatNames);
        assertNotNull(beans);
        assertEquals(1, beans.size());
        assertEquals("A1", beans.get(0));
    }

    @Test
    public void testCheckDoubleBooking002() {
        TripDAO tripDAO = (TripDAO) getBean("tripDAO");
        List<TripBean> trips = new ArrayList<TripBean>();
        trips.add(tripDAO.getById(4));
        trips.add(tripDAO.getById(5));
        List<String> seatNames = new ArrayList<String>();
        seatNames.add("A1");
        seatNames.add("B1");
        seatNames.add("B2");
        SeatPositionDAO seatPositionDAO = (SeatPositionDAO) getBean("seatPositionDAO");
        List<String> beans = seatPositionDAO.checkDoubleBooking(trips,
                seatNames);
        assertNotNull(beans);
        assertEquals(1, beans.size());
        assertEquals("A1", beans.get(0));
    }
}
