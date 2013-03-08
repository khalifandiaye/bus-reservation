package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.ArrangedReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;

public class ReservationDAO extends GenericDAO<Integer, ReservationBean> {

    public ReservationDAO(Class<ReservationBean> clazz) {
        super(clazz);
    }

    @SuppressWarnings("unchecked")
    public ReservationBean getByCode(String code) {
        List<ReservationBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT res FROM ReservationBean AS res WHERE res.code = ?";
            query = session.createQuery(queryString);
            query.setString(0, code);
            result = query.list();
            // commit transaction
            // session.getTransaction().commit();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        if (result == null || result.size() <= 0) {
            return null;
        } else {
            return result.get(0);
        }
    }

    @SuppressWarnings("unchecked")
    public List<ArrangedReservationBean> getArrangedReservations(String username) {
        List<ArrangedReservationBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT DISTINCT new vn.edu.fpt.capstone.busReservation.dao.bean.ArrangedReservationBean(rsv, tkt1, trp1.departureTime, tkt2, trp2.departureTime)"
                    + " FROM ReservationBean rsv"
                    + "    INNER JOIN rsv.tickets tkt1"
                    + "    INNER JOIN tkt1.trips trp1"
                    + "    INNER JOIN rsv.tickets tkt2"
                    + "    INNER JOIN tkt2.trips trp2"
                    + " WHERE rsv.booker.username = :username"
                    + " AND trp1.departureTime = (SELECT MIN(trps.departureTime)"
                    + "     FROM TicketBean tkts INNER JOIN tkts.trips trps"
                    + "    WHERE tkts = tkt1)"
                    + " AND trp2.departureTime = (SELECT MIN(trps.departureTime)"
                    + "     FROM TicketBean tkts INNER JOIN tkts.trips trps"
                    + "    WHERE tkts = tkt2)"
                    + " AND (trp1.departureTime < trp2.departureTime"
                    + "    OR (tkt1 = tkt2"
                    + "    AND 0 = (SELECT COUNT(*)"
                    + "        FROM ReservationBean rsvs"
                    + "            INNER JOIN rsvs.tickets tkts1"
                    + "            INNER JOIN rsvs.tickets tkts2"
                    + "        WHERE rsvs = rsv"
                    + "        AND tkts1 != tkts2)))";
            query = session.createQuery(queryString);
            query.setString("username", username);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    @SuppressWarnings("unchecked")
    public ArrangedReservationBean getArrangedReservation(int id) {
        List<ArrangedReservationBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT DISTINCT new vn.edu.fpt.capstone.busReservation.dao.bean.ArrangedReservationBean(rsv, tkt1, trp1.departureTime, tkt2, trp2.departureTime)"
                    + " FROM ReservationBean rsv"
                    + "    INNER JOIN rsv.tickets tkt1"
                    + "    INNER JOIN tkt1.trips trp1"
                    + "    INNER JOIN rsv.tickets tkt2"
                    + "    INNER JOIN tkt2.trips trp2"
                    + " WHERE rsv.id = :id"
                    + " AND trp1.departureTime = (SELECT MIN(trps.departureTime)"
                    + "     FROM TicketBean tkts INNER JOIN tkts.trips trps"
                    + "    WHERE tkts = tkt1)"
                    + " AND trp2.departureTime = (SELECT MIN(trps.departureTime)"
                    + "     FROM TicketBean tkts INNER JOIN tkts.trips trps"
                    + "    WHERE tkts = tkt2)"
                    + " AND (trp1.departureTime < trp2.departureTime"
                    + "    OR (tkt1 = tkt2"
                    + "    AND 0 = (SELECT COUNT(*)"
                    + "        FROM ReservationBean rsvs"
                    + "            INNER JOIN rsvs.tickets tkts1"
                    + "            INNER JOIN rsvs.tickets tkts2"
                    + "        WHERE rsvs = rsv"
                    + "        AND tkts1 != tkts2)))";
            query = session.createQuery(queryString);
            query.setInteger("id", id);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        if (result == null || result.size() <= 0) {
            return null;
        } else {
            return result.get(0);
        }
    }

}
