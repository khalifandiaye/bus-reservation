package vn.edu.fpt.capstone.busReservation.dao;

import java.util.Calendar;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionKey;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

public class SeatPositionDAO extends
        GenericDAO<SeatPositionKey, SeatPositionBean> {

    public SeatPositionDAO(Class<SeatPositionBean> clazz) {
        super(clazz);
        // TODO Auto-generated constructor stub
    }

    @SuppressWarnings("unchecked")
    public List<String> checkDoubleBooking(List<TripBean> trips,
            List<String> seatNames) {
        List<String> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        Calendar timeLimit = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            timeLimit = Calendar.getInstance();
            timeLimit.add(Calendar.MINUTE, -CommonConstant.RESERVATION_TIMEOUT);
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT DISTINCT stp.name FROM TripBean AS trp INNER JOIN trp.reservations AS rsv INNER JOIN rsv.seatPositions AS stp WHERE trp IN (:trips) AND stp.name IN (:seatNames) AND (rsv.status = :statusPaid OR (rsv.status = :statusUnpaid AND rsv.bookTime > :timeLimit))";
            query = session.createQuery(queryString);
            query.setParameterList("trips", trips);
            query.setParameterList("seatNames", seatNames);
            query.setString("statusPaid", ReservationStatus.PAID.getValue());
            query.setString("statusUnpaid", ReservationStatus.UNPAID.getValue());
            query.setTimestamp("timeLimit", timeLimit.getTime());
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }
    
//    public void removeDoubleBooking(List<SeatPositionBean> stpList) {
//        Query query = null;
//        String queryString = null;
//        Session session = null;
//        Calendar timeLimit = null;
//        // get the current session
//        session = sessionFactory.getCurrentSession();
//        try {
//            timeLimit = Calendar.getInstance();
//            timeLimit.add(Calendar.MINUTE, -CommonConstant.RESERVATION_TIMEOUT);
//            // perform database access (query, insert, update, etc) here
//            queryString = "DELETE SeatPositionBean stp WHERE stp IN (:stpList) AND stp IN (SELECT stp1 FROM SeatPositionBean AS stp1 INNER JOIN stp1.reservation.trips AS trp INNER JOIN trp.reservations AS rsv INNER JOIN rsv.seatPositions AS stp2 WHERE stp1 = stp AND rsv != stp1.reservation AND stp1.name = stp2.name)";
//            query = session.createQuery(queryString);
//            query.setParameterList("stpList", stpList);
//            query.executeUpdate();
//            queryString = "DELETE ReservationBean rsv WHERE rsv.seatPositions is empty";
//            query = session.createQuery(queryString);
//            query.executeUpdate();
//        } catch (HibernateException e) {
//            exceptionHandling(e, session);
//        }
//    }
    
    @SuppressWarnings("unchecked")
    public List<String> getSoldSeats(List<TripBean> trips) {
        List<String> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        Calendar timeLimit = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            timeLimit = Calendar.getInstance();
            timeLimit.add(Calendar.MINUTE, -CommonConstant.RESERVATION_TIMEOUT);
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT DISTINCT stp.name FROM TripBean AS trp" +
            		" INNER JOIN trp.reservations AS rsv" +
            		" INNER JOIN rsv.seatPositions AS stp" +
            		" WHERE trp IN (:trips)" +
            		" AND (rsv.status = :statusPaid OR (rsv.status = :statusUnpaid AND rsv.bookTime > :timeLimit))";
            query = session.createQuery(queryString);
            query.setParameterList("trips", trips);
            query.setString("statusPaid", ReservationStatus.PAID.getValue());
            query.setString("statusUnpaid", ReservationStatus.UNPAID.getValue());
            query.setTimestamp("timeLimit", timeLimit.getTime());
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

}
