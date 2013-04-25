/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 * 
 */
public class SeatPositionDAOTest extends DAOTest {
//    @Test
    public void testGetById001() {
//        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
//        TicketBean reservationBean = reservationDAO.getById(1);
//        SeatPositionDAO seatPositionDAO = (SeatPositionDAO) getBean("seatPositionDAO");
//        SeatPositionKey key = new SeatPositionKey();
//        key.setName("A1");
//        key.setTicket(reservationBean);
//        SeatPositionBean bean = seatPositionDAO.getById(key);
//        Assert.assertNotNull(bean);
    }

//    @Test
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

//    @Test
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

    @Test
    public void testGetSoldSeat001() throws ParseException {
//        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
//        TripDAO tripDAO = (TripDAO) getBean("tripDAO");
//        // Prepare data
//        // =Get base data
//        List<TripBean> trips = new ArrayList<TripBean>();
//        trips.add(tripDAO.getById(14));
//        // =Clean data
////        for (TripBean trip : trips) {
////            if (trip.getReservations() != null) {
////                for (ReservationBean reservation : trip.getReservations()) {
////                    delete(reservation.getSeatPositions());
////                    delete(reservation.getPayments());
////                    reservationDAO.refresh(reservation);
////                    reservation.setTrips(null);
////                }
////                reservationDAO.update(trip.getReservations());
////                delete(trip.getReservations());
////            }
////        }
//        // =Add test data
//        List<ReservationBean> reservations = new ArrayList<ReservationBean>();
//        ReservationBean reservation = null;
//        UserBean booker = ((UserDAO) getBean("userDAO")).getById(1);
//        SeatPositionDAO seatPositionDAO = (SeatPositionDAO) getBean("seatPositionDAO");
//        List<SeatPositionBean> seatPositionBeans = new ArrayList<SeatPositionBean>();
//        SeatPositionBean seatPositionBean = null;
//        reservation = new ReservationBean();
//        reservation.setBooker(booker);
//        reservation.setBookerFirstName(booker.getFirstName());
//        reservation.setBookerLastName(booker.getLastName());
//        reservation.setEmail(booker.getEmail());
//        reservation.setPhone(booker.getPhoneNumber() == null ? "123456789"
//                : booker.getPhoneNumber());
//        // ==Important: bookTime = now - 10mins
//        Calendar bookTime = Calendar.getInstance();
//        bookTime.add(Calendar.MINUTE, -10);
//        reservation.setBookTime(bookTime.getTime());
////        reservation.setTrips(trips);
//        reservation.setStatus(ReservationStatus.UNPAID.getValue());
//        reservations.add(reservation);
//        // ==Important: seatPositions = A1, A2
//        seatPositionBean = new SeatPositionBean();
//        seatPositionBean.setName("A1");
////        seatPositionBean.setReservation(reservation);
//        seatPositionBeans.add(seatPositionBean);
//        seatPositionBean = new SeatPositionBean();
//        seatPositionBean.setName("A2");
////        seatPositionBean.setReservation(reservation);
//        seatPositionBeans.add(seatPositionBean);
//        reservationDAO.insert(reservations);
//        seatPositionDAO.insert(seatPositionBeans);
//
//        // Call method
//        List<String> seatNames = seatPositionDAO.getSoldSeats(trips);
//        assertNotNull(seatNames);
//        assertEquals(2, seatNames.size());
//        // =Clean test data
////        delete(seatPositionBeans);
////        for (ReservationBean bean : reservations) {
////            bean.setTrips(null);
////        }
////        reservationDAO.update(reservations);
////        delete(reservations);
    }

    @Test
    public void testGetSoldSeat002() throws ParseException {
//        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
//        TripDAO tripDAO = (TripDAO) getBean("tripDAO");
//        // Prepare data
//        // =Get a trip list
//        List<TripBean> trips = new ArrayList<TripBean>();
//        trips.add(tripDAO.getById(14));
//        // =Remove all exists reservation
//        for (TripBean trip : trips) {
//            if (trip.getReservations() != null) {
//                for (ReservationBean reservation : trip.getReservations()) {
//                    delete(reservation.getSeatPositions());
//                    delete(reservation.getPayments());
//                    reservationDAO.refresh(reservation);
//                    reservation.setTrips(null);
//                }
//                reservationDAO.update(trip.getReservations());
//                delete(trip.getReservations());
//            }
//        }
//        // =Add new reservation(s)
//        List<ReservationBean> reservations = new ArrayList<ReservationBean>();
//        ReservationBean reservation = null;
//        UserBean booker = ((UserDAO) getBean("userDAO")).getById(1);
//        SeatPositionDAO seatPositionDAO = (SeatPositionDAO) getBean("seatPositionDAO");
//        List<SeatPositionBean> seatPositionBeans = new ArrayList<SeatPositionBean>();
//        SeatPositionBean seatPositionBean = null;
//        reservation = new ReservationBean();
//        reservation.setBooker(booker);
//        reservation.setBookerFirstName(booker.getFirstName());
//        reservation.setBookerLastName(booker.getLastName());
//        reservation.setEmail(booker.getEmail());
//        reservation.setPhone(booker.getPhoneNumber() == null ? "123456789"
//                : booker.getPhoneNumber());
//        // ==Important: bookTime = now - 20mins
//        Calendar bookTime = Calendar.getInstance();
//        bookTime.add(Calendar.MINUTE, -16);
//        reservation.setBookTime(bookTime.getTime());
//        reservation.setTrips(trips);
//        reservation.setStatus(ReservationStatus.UNPAID.getValue());
//        reservations.add(reservation);
//        // ==Important: seatPositions = A1, A2
//        seatPositionBean = new SeatPositionBean();
//        seatPositionBean.setName("A1");
//        seatPositionBean.setReservation(reservation);
//        seatPositionBeans.add(seatPositionBean);
//        seatPositionBean = new SeatPositionBean();
//        seatPositionBean.setName("A2");
//        seatPositionBean.setReservation(reservation);
//        seatPositionBeans.add(seatPositionBean);
//        reservationDAO.insert(reservations);
//        seatPositionDAO.insert(seatPositionBeans);
//
//        // Call method
//        List<String> seatNames = seatPositionDAO.getSoldSeats(trips);
//        assertNotNull(seatNames);
//        assertEquals(0, seatNames.size());
//        // remove
////        delete(seatPositionBeans);
////        for (ReservationBean bean : reservations) {
////            bean.setTrips(null);
////        }
////        reservationDAO.update(reservations);
////        delete(reservations);
    }
}
