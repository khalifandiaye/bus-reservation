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
        ReservationBean bean = reservationDAO.getById(130);
        Assert.assertNotNull(bean);
        Assert.assertNotEquals(0, bean.getSeatPositions().size());
    }

//    @Test
//    public void testUpdate001() {
//        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
//        List<ReservationBean> beans = reservationDAO.getAll();
//        Assert.assertNotNull(beans);
//        Assert.assertNotEquals(0, beans.size());
//        Assert.assertNotNull(beans.get(0));
//        Assert.assertNotEquals(0, beans.get(0).getTrips().size());
//        Calendar bookTime = Calendar.getInstance();
//        Random random = new Random();
//        bookTime.add(Calendar.DATE, 14);
//        for (ReservationBean reservationBean : beans) {
//            if (random.nextInt(10) < 6) {
//                bookTime.add(Calendar.DATE, random.nextInt(13) - 6);
//                bookTime.add(Calendar.HOUR, random.nextInt(47) - 23);
//                bookTime.add(Calendar.MINUTE, random.nextInt(119) - 59);
//                bookTime.add(Calendar.SECOND, random.nextInt(119) - 59);
//                reservationBean.setBookTime(bookTime.getTime());
//            }
//        }
//        reservationDAO.update(beans);
//    }

    // @Test
    // public void testInsert001() {
    // Random random = new Random();
    // UserBean booker = ((UserDAO) getBean("userDAO")).getById(1);
    // ReservationDAO reservationDAO = (ReservationDAO)
    // getBean("reservationDAO");
    // ReservationBean bean = null;
    // List<ReservationBean> beans = new ArrayList<ReservationBean>();
    // Calendar bookTime = Calendar.getInstance();
    // BusStatusDAO busStatusDAO = (BusStatusDAO) getBean("busStatusDAO");
    // BusStatusBean busStatusBean = null;
    // List<TripBean> trips = null;
    // SeatPositionDAO seatPositionDAO = (SeatPositionDAO)
    // getBean("seatPositionDAO");
    // List<SeatPositionBean> seatPositionBeans = new
    // ArrayList<SeatPositionBean>();
    // SeatPositionBean seatPositionBean = null;
    // int from = 0;
    // int to = 0;
    // char letter = 0;
    // int number = 0;
    // bookTime.add(Calendar.DATE, 7);
    // for (int i = 0; i < 23; i++) {
    // bean = new ReservationBean();
    // bean.setBooker(booker);
    // bean.setBookerFirstName(booker.getFirstName());
    // bean.setBookerLastName(booker.getLastName());
    // bean.setEmail(booker.getEmail());
    // bean.setPhone(booker.getPhoneNumber() == null ? "123456789" :
    // booker.getPhoneNumber());
    // bookTime.add(Calendar.DATE, random.nextInt(13) - 6);
    // bookTime.add(Calendar.HOUR, random.nextInt(47) - 23);
    // bookTime.add(Calendar.MINUTE, random.nextInt(119) - 59);
    // bookTime.add(Calendar.SECOND, random.nextInt(119) - 59);
    // bean.setBookTime(bookTime.getTime());
    // busStatusBean = busStatusDAO.getById(random.nextInt(10) + 4);
    // if (busStatusBean != null) {
    // from = random.nextInt(busStatusBean.getTrips().size());
    // to = from
    // + random.nextInt(busStatusBean.getTrips().size() - from)
    // + 1;
    // trips = new ArrayList<TripBean>();
    // for (int j = from; j < to; j++) {
    // trips.add(busStatusBean.getTrips().get(j));
    // }
    // bean.setTrips(trips);
    // bean.setStatus(ReservationStatus.UNPAID.getValue());
    // beans.add(bean);
    // to = random.nextInt(5);
    // for (int j = 0; j < 5; j++) {
    // seatPositionBean = new SeatPositionBean();
    // letter = (char) ('A' + random.nextInt(4));
    // number = 1 + random.nextInt(20);
    // seatPositionBean.setName(Character.toString(letter)
    // + Integer.toString(number));
    // seatPositionBean.setReservation(bean);
    // seatPositionBeans.add(seatPositionBean);
    // }
    // }
    // }
    // reservationDAO.insert(beans);
    // seatPositionDAO.insert(seatPositionBeans);
    // // seatPositionDAO.removeDoubleBooking(seatPositionBeans);
    // }
}
