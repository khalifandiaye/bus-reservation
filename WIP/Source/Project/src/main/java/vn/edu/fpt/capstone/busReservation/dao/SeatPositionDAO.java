package vn.edu.fpt.capstone.busReservation.dao;

import java.util.Calendar;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionKey;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

public class SeatPositionDAO extends
        GenericDAO<SeatPositionKey, SeatPositionBean> {

    public SeatPositionDAO(Class<SeatPositionBean> clazz) {
        super(clazz);
        // TODO Auto-generated constructor stub
    }
    
    @SuppressWarnings("unchecked")
    public boolean isDoubleBooking(List<TripBean> trips, List<String> seatNames) {
        List<TripBean> result = null;
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
            queryString = "SELECT trp FROM TripBean AS trp INNER JOIN trp.reservations AS rsv INNER JOIN rsv.seatPositions AS stp WHERE trp IN :trips AND stp.name IN :seats AND (rsv.status = :statusPaid OR (rsv.status = :statusUnpaid && rsv.bookTime > :timeLimit))";
            query = session.createQuery(queryString);
            query.setParameterList("trips", trips);
            query.setParameterList("seatNames", seatNames);
            query.setString("statusPaid", ReservationStatus.PAID.getValue());
            query.setString("statusUnpaid", ReservationStatus.UNPAID.getValue());
            query.setDate("timeLimit", timeLimit.getTime());
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result != null && result.size() >0;
    }

}
