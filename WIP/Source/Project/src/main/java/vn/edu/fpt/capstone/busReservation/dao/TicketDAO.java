/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean.TicketStatus;
import vn.edu.fpt.capstone.busReservation.displayModel.SimpleReservationInfo;

/**
 * @author Yoshimi
 * 
 */
public class TicketDAO extends GenericDAO<Integer, TicketBean> {

    // private static final ResultTransformer TICKET_INFO_TRANSFORMER = new
    // ResultTransformer() {
    //
    // /**
    // *
    // */
    // private static final long serialVersionUID = 1L;
    //
    // @Override
    // public Object transformTuple(Object[] tuple, String[] aliases) {
    // TicketInfoBean info = new TicketInfoBean();
    // int size = aliases.length;
    // for (int i = 0; i < size; i++) {
    // if ("ticket".equalsIgnoreCase(aliases[i])) {
    // info.setId((TicketBean) tuple[i]);
    // } else if ("startTrip".equalsIgnoreCase(aliases[i])) {
    // info.setStartTrip((TripBean) tuple[i]);
    // } else if ("endTrip".equalsIgnoreCase(aliases[i])) {
    // info.setEndTrip((TripBean) tuple[i]);
    // } else if ("ticketPrice".equalsIgnoreCase(aliases[i])) {
    // info.setTicketPrice((Double) tuple[i]);
    // }
    // }
    // return info;
    // }
    //
    // @SuppressWarnings("rawtypes")
    // @Override
    // public List transformList(List collection) {
    // return collection;
    // }
    // };

    public TicketDAO(Class<TicketBean> clazz) {
        super(clazz);
        // TODO Auto-generated constructor stub
    }

    @SuppressWarnings("unchecked")
    public List<SimpleReservationInfo> getSimpleInfoByUsername(String username) {
        List<SimpleReservationInfo> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT new vn.edu.fpt.capstone.busReservation.displayModel.SimpleReservationInfo(rsv.id, tkt.id, stas, stae, trps.departureTime, rsv.bookTime, rsv.status, tkt.status)"
                    + " FROM TicketBean tkt"
                    + "     INNER JOIN tkt.trips trps"
                    + "     INNER JOIN trps.routeDetails.segment.startAt stas"
                    + "     INNER JOIN tkt.trips trpe"
                    + "     INNER JOIN trpe.routeDetails.segment.endAt stae"
                    + "     INNER JOIN tkt.reservation rsv"
                    + " WHERE rsv.booker.username = :username"
                    + " AND rsv.status != :rsvStatusMoved"
                    + " AND tkt.status != :ticketStatusMoved"
                    + " AND trps.departureTime = (SELECT MIN(trp1.departureTime)"
                    + "     FROM TicketBean tkt1 INNER JOIN tkt1.trips trp1"
                    + "     WHERE tkt1 = tkt)"
                    + " AND trpe.departureTime = (SELECT MAX(trp2.departureTime)"
                    + "     FROM TicketBean tkt2 INNER JOIN tkt2.trips trp2"
                    + "     WHERE tkt2 = tkt)" + " GROUP BY tkt, trps, trpe";
            query = session.createQuery(queryString);
            query.setString("username", username);
            query.setString("rsvStatusMoved",
                    ReservationStatus.MOVED.getValue());
            query.setString("ticketStatusMoved", TicketStatus.MOVED.getValue());
            // query.setResultTransformer(TICKET_INFO_TRANSFORMER);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<SimpleReservationInfo> getSimpleInfoById(int reservationId) {
        List<SimpleReservationInfo> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT new vn.edu.fpt.capstone.busReservation.displayModel.SimpleReservationInfo(tkt.id, stas, stae, trps.departureTime, rsv.bookTime, rsv.status, tkt.status)"
                    + " FROM TicketBean tkt"
                    + "     INNER JOIN tkt.trips trps"
                    + "     INNER JOIN trps.routeDetails.segment.startAt stas"
                    + "     INNER JOIN tkt.trips trpe"
                    + "     INNER JOIN trpe.routeDetails.segment.startAt stae"
                    + "     INNER JOIN tkt.reservation rsv"
                    + " WHERE rsv.id = :reservationId"
                    + " AND rsv.status != :rsvStatusMoved"
                    + " AND tkt.status != :ticketStatusMoved"
                    + " AND trps.departureTime = (SELECT MIN(trp1.departureTime)"
                    + "     FROM TicketBean tkt1 INNER JOIN tkt1.trips trp1"
                    + "     WHERE tkt1 = tkt)"
                    + " AND trpe.departureTime = (SELECT MAX(trp2.departureTime)"
                    + "     FROM TicketBean tkt2 INNER JOIN tkt2.trips trp2"
                    + "     WHERE tkt2 = tkt)" + " GROUP BY tkt, trps, trpe";
            query = session.createQuery(queryString);
            query.setInteger("reservationId", reservationId);
            query.setString("rsvStatusMoved",
                    ReservationStatus.MOVED.getValue());
            query.setString("ticketStatusMoved", TicketStatus.MOVED.getValue());
            // query.setResultTransformer(TICKET_INFO_TRANSFORMER);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<TicketBean> getTicketByBusStatusId(int busStatusId) {
        String hql = "SELECT tr.tickets FROM TripBean tr "
                + "LEFT JOIN tr.tickets "
                + "WHERE tr.busStatus.id = :busStatusId ";
        Session session = sessionFactory.getCurrentSession();
        List<TicketBean> result = new ArrayList<TicketBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setInteger("busStatusId", busStatusId);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

}
