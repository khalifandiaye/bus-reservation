package vn.edu.fpt.capstone.busReservation.dao;

import java.util.Calendar;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionKey;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean.TicketStatus;
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
//            queryString = "SELECT DISTINCT stp.name FROM TripBean AS trp INNER JOIN trp.reservations AS rsv INNER JOIN rsv.seatPositions AS stp WHERE trp IN (:trips) AND stp.name IN (:seatNames) AND (rsv.status = :statusPaid OR (rsv.status = :statusUnpaid AND rsv.bookTime > :timeLimit))";
            queryString = "SELECT DISTINCT stp.name FROM TripBean AS trp" +
            		" INNER JOIN trp.tickets AS tic" +
            		" INNER JOIN tic.seatPositions AS stp" +
            		" INNER JOIN tic.reservation AS rsv" +
            		" WHERE trp IN (:trips)" +
            		" AND stp.name IN (:seatNames)" +
            		" AND (rsv.status = :statusPaid OR rsv.status = :statusPending OR (rsv.status = :statusUnpaid AND rsv.bookTime > :timeLimit))" + 
            		" AND (tic.status = :statusTicActive OR tic.status = :statusTicPending)";
            query = session.createQuery(queryString);
            query.setParameterList("trips", trips);
            query.setParameterList("seatNames", seatNames);
            query.setString("statusPending", ReservationStatus.PENDING.getValue());
            query.setString("statusPaid", ReservationStatus.PAID.getValue());
            query.setString("statusUnpaid", ReservationStatus.UNPAID.getValue());
            query.setTimestamp("timeLimit", timeLimit.getTime());
            query.setString("statusTicActive", TicketStatus.ACTIVE.getValue());
            query.setString("statusTicPending", TicketStatus.PENDING.getValue());
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result.size()>0 ? result : null;
    }
    
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
            		" INNER JOIN trp.tickets AS tic" +
            		" INNER JOIN tic.seatPositions AS stp" +
            		" INNER JOIN tic.reservation AS rsv" +
            		" WHERE trp IN (:trips)" +
            		" AND (rsv.status = :statusPaid OR rsv.status = :statusPending OR (rsv.status = :statusUnpaid AND rsv.bookTime > :timeLimit))" +
            		" AND (tic.status = :statusTicActive OR tic.status = :statusTicPending)";
            query = session.createQuery(queryString);
            query.setParameterList("trips", trips);
            query.setString("statusPending", ReservationStatus.PENDING.getValue());
            query.setString("statusPaid", ReservationStatus.PAID.getValue());
            query.setString("statusUnpaid", ReservationStatus.UNPAID.getValue());
            query.setTimestamp("timeLimit", timeLimit.getTime());
            query.setString("statusTicActive", TicketStatus.ACTIVE.getValue());
            query.setString("statusTicPending", TicketStatus.PENDING.getValue());
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

}
