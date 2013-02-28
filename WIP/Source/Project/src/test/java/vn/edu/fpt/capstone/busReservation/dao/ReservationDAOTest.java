/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
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
        assertNotNull(beans);
        assertNotEquals(0, beans.size());
        assertNotNull(beans.get(0));
        assertNotEquals(0, beans.get(0).getTrips().size());
    }

    @Test
    public void testGetById001() {
        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
        ReservationBean bean = reservationDAO.getById(130);
        assertNotNull(bean);
        assertNotEquals(0, bean.getSeatPositions().size());
    }
    
    @Test(expected = HibernateException.class)
    public void testInsert002() {
        TripDAO tripDAO = (TripDAO) getBean("tripDAO");
        List<TripBean> trips1 = null;
        List<TripBean> trips2 = null;
        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
        ReservationBean reservation1 = null;
        ReservationBean reservation2 = null;
        SeatPositionDAO seatPositionDAO = (SeatPositionDAO) getBean("seatPositionDAO");
        List<SeatPositionBean> seatPositions1 = null;
        List<SeatPositionBean> seatPositions2 = null;
        SeatPositionBean seatPosition = null;
        trips1 = new ArrayList<TripBean>();
        trips1.add(tripDAO.getById(17));
        trips1.add(tripDAO.getById(18));
        trips1.add(tripDAO.getById(19));
        trips2 = new ArrayList<TripBean>();
        trips2.add(tripDAO.getById(16));
        trips2.add(tripDAO.getById(17));
        // clean data
        for (TripBean trip : trips1) {
            List<ReservationBean> reservations = trip.getReservations();
            for (ReservationBean reservation : reservations) {
                reservation.setTrips(null);
                delete(reservation.getSeatPositions());
                delete(reservation.getPayments());
            }
            reservationDAO.update(reservations);
            delete(reservations);
        }
        for (TripBean trip : trips2) {
            List<ReservationBean> reservations = trip.getReservations();
            for (ReservationBean reservation : reservations) {
                reservation.setTrips(null);
                delete(reservation.getSeatPositions());
                delete(reservation.getPayments());
            }
            reservationDAO.update(reservations);
            delete(reservations);
        }
        reservation1 = new ReservationBean();
        reservation1.setBookerFirstName("Hai");
        reservation1.setBookerLastName("Nguyen Minh");
        reservation1.setPhone("123456");
        reservation1.setEmail("email@someHost.com");
        reservation1.setTrips(trips1);
        reservation1.setBookTime(new Date());
        reservation1.setStatus(ReservationStatus.UNPAID.getValue());
        seatPositions1 = new ArrayList<SeatPositionBean>();
        seatPosition = new SeatPositionBean();
        seatPositions1.add(seatPosition);
        seatPosition.setReservation(reservation1);
        seatPosition.setName("A1");
        seatPosition = new SeatPositionBean();
        seatPositions1.add(seatPosition);
        seatPosition.setReservation(reservation1);
        seatPosition.setName("A2");
        seatPosition = new SeatPositionBean();
        seatPositions1.add(seatPosition);
        seatPosition.setReservation(reservation1);
        seatPosition.setName("A3");
        reservation2 = new ReservationBean();
        reservation2.setBookerFirstName("Hai");
        reservation2.setBookerLastName("Nguyen Minh");
        reservation2.setPhone("123456");
        reservation2.setEmail("email@someHost.com");
        reservation2.setTrips(trips2);
        reservation2.setBookTime(new Date());
        reservation2.setStatus(ReservationStatus.UNPAID.getValue());
        seatPositions2 = new ArrayList<SeatPositionBean>();
        seatPosition = new SeatPositionBean();
        seatPositions2.add(seatPosition);
        seatPosition.setReservation(reservation2);
        seatPosition.setName("A3");
        seatPosition = new SeatPositionBean();
        seatPositions2.add(seatPosition);
        seatPosition.setReservation(reservation2);
        seatPosition.setName("A4");
        seatPosition = new SeatPositionBean();
        seatPositions2.add(seatPosition);
        seatPosition.setReservation(reservation2);
        seatPosition.setName("A5");
        reservationDAO.insert(reservation1);
        reservationDAO.insert(reservation2);
        seatPositionDAO.insert(seatPositions1);
        try {
            seatPositionDAO.insert(seatPositions2);
        } catch (HibernateException e) {
            assertEquals("msgerrdb0002", e.getMessage());
            throw e;
        }
    }

    // @Test
    // public void testUpdate001() {
    // ReservationDAO reservationDAO = (ReservationDAO)
    // getBean("reservationDAO");
    // List<ReservationBean> beans = reservationDAO.getAll();
    // Assert.assertNotNull(beans);
    // Assert.assertNotEquals(0, beans.size());
    // Assert.assertNotNull(beans.get(0));
    // Assert.assertNotEquals(0, beans.get(0).getTrips().size());
    // Calendar bookTime = Calendar.getInstance();
    // Random random = new Random();
    // bookTime.add(Calendar.DATE, 14);
    // for (ReservationBean reservationBean : beans) {
    // if (random.nextInt(10) < 6) {
    // bookTime.add(Calendar.DATE, random.nextInt(13) - 6);
    // bookTime.add(Calendar.HOUR, random.nextInt(47) - 23);
    // bookTime.add(Calendar.MINUTE, random.nextInt(119) - 59);
    // bookTime.add(Calendar.SECOND, random.nextInt(119) - 59);
    // reservationBean.setBookTime(bookTime.getTime());
    // }
    // }
    // reservationDAO.update(beans);
    // }

//    @Test
//    public void testInsert001() {
//        Random random = new Random();
//        UserBean booker = ((UserDAO) getBean("userDAO")).getById(1);
//        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
//        ReservationBean bean = null;
//        List<ReservationBean> beans = new ArrayList<ReservationBean>();
//        Calendar bookTime = Calendar.getInstance();
//        BusStatusDAO busStatusDAO = (BusStatusDAO) getBean("busStatusDAO");
//        BusStatusBean busStatusBean = null;
//        List<TripBean> trips = null;
//        SeatPositionDAO seatPositionDAO = (SeatPositionDAO) getBean("seatPositionDAO");
//        List<SeatPositionBean> seatPositionBeans = new ArrayList<SeatPositionBean>();
//        SeatPositionBean seatPositionBean = null;
//        int from = 0;
//        int to = 0;
//        char letter = 0;
//        int number = 0;
//        int count = 0;
////        bookTime.add(Calendar.DATE, 7);
//        count = random.nextInt(100) + 50;
//        for (int i = 0; i < count; i++) {
//            bean = new ReservationBean();
//            bean.setBooker(booker);
//            bean.setBookerFirstName(booker.getFirstName());
//            bean.setBookerLastName(booker.getLastName());
//            bean.setEmail(booker.getEmail());
//            bean.setPhone(booker.getPhoneNumber() == null ? "123456789"
//                    : booker.getPhoneNumber());
//            bookTime.add(Calendar.DATE, random.nextInt(20));
//            bookTime.add(Calendar.HOUR, random.nextInt(23) - 11);
//            bookTime.add(Calendar.MINUTE, random.nextInt(119) - 59);
//            bookTime.add(Calendar.SECOND, random.nextInt(119) - 59);
//            bean.setBookTime(bookTime.getTime());
//            busStatusBean = busStatusDAO.getById(random.nextInt(10) + 4);
//            if (busStatusBean != null) {
//                from = random.nextInt(busStatusBean.getTrips().size());
//                to = from
//                        + random.nextInt(busStatusBean.getTrips().size() - from)
//                        + 1;
//                while (bookTime.after(busStatusBean.getTrips().get(from).getDepartureTime())) {
//                    bookTime.add(Calendar.DATE, -random.nextInt(10) - 1);
//                }
//                trips = new ArrayList<TripBean>();
//                for (int j = from; j < to; j++) {
//                    trips.add(busStatusBean.getTrips().get(j));
//                }
//                bean.setTrips(trips);
//                bean.setStatus(ReservationStatus.UNPAID.getValue());
//                beans.add(bean);
//                to = random.nextInt(5) + 1;
//                for (int j = 0; j < to; j++) {
//                    seatPositionBean = new SeatPositionBean();
//                    letter = (char) ('A' + random.nextInt(4));
//                    number = 1 + random.nextInt(11);
//                    seatPositionBean.setName(Character.toString(letter)
//                            + Integer.toString(number));
//                    seatPositionBean.setReservation(bean);
//                    seatPositionBeans.add(seatPositionBean);
//                }
//            }
//        }
//        reservationDAO.insert(beans);
//        seatPositionDAO.insert(seatPositionBeans);
//        // seatPositionDAO.removeDoubleBooking(seatPositionBeans);
//    }
}
