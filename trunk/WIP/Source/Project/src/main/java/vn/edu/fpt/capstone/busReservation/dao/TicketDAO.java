/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.ResultTransformer;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean.TicketStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketInfoBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SimpleReservationInfo;

/**
 * @author Yoshimi
 * 
 */
public class TicketDAO extends GenericDAO<Integer, TicketBean> {

    public static final ResultTransformer TICKET_INFO_BEAN_TRANSFORMER = new ResultTransformer() {

        /**
         * 
         */
        private static final long serialVersionUID = 1L;

        @Override
        public Object transformTuple(Object[] tuple, String[] aliases) {
//            ((TicketBean) tuple[0]).getSeatPositions().size();
//            ((TicketBean) tuple[0]).getPayments().size();
            return tuple == null ? null : new TicketInfoBean(
                    (TicketBean) tuple[0], (TripBean) tuple[1],
                    (TripBean) tuple[2], (Double) tuple[3]);
        }

        @SuppressWarnings("rawtypes")
        @Override
        public List transformList(List collection) {
            // TODO Auto-generated method stub
            return collection;
        }
    };

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
            queryString = "SELECT DISTINCT new vn.edu.fpt.capstone.busReservation.displayModel.SimpleReservationInfo(rsv.id, tkt.id, stas, stae, trps.departureTime, rsv.bookTime, rsv.status, tkt.status)"
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
            queryString = "SELECT DISTINCT new vn.edu.fpt.capstone.busReservation.displayModel.SimpleReservationInfo(tkt.id, stas, stae, trps.departureTime, rsv.bookTime, rsv.status, tkt.status)"
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
    public List<TicketBean> getTickets(int reservationId) {
        List<TicketBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT DISTINCT tkt" + " FROM TicketBean tkt"
                    + " INNER JOIN tkt.reservation rsv"
                    + " INNER JOIN tkt.trips trps"
                    + " WHERE rsv.id = :reservationId"
                    + "     AND rsv.status != :rsvStatusMoved"
                    + "     AND tkt.status != :ticketStatusMoved"
                    + " ORDER BY trps.departureTime";
            query = session.createQuery(queryString);
            query.setInteger("reservationId", reservationId);
            query.setString("rsvStatusMoved",
                    ReservationStatus.MOVED.getValue());
            query.setString("ticketStatusMoved", TicketStatus.MOVED.getValue());
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<TicketBean> getTicketsByCode(String reservationCode,
            String email) {
        List<TicketBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT DISTINCT tkt FROM TicketBean tkt"
                    + " INNER JOIN tkt.reservation rsv"
                    + " INNER JOIN tkt.trips trps"
                    + " WHERE rsv.code = :reservationCode"
                    + "     AND rsv.email = :email"
                    + "     AND rsv.status != :rsvStatusMoved"
                    + "     AND tkt.status != :ticketStatusMoved"
                    + " ORDER BY trps.departureTime";
            query = session.createQuery(queryString);
            query.setString("reservationCode", reservationCode);
            query.setString("email", email);
            query.setString("rsvStatusMoved",
                    ReservationStatus.MOVED.getValue());
            query.setString("ticketStatusMoved", TicketStatus.MOVED.getValue());
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    @SuppressWarnings("unchecked")
    public TicketInfoBean getTicketInfoById(int ticketId) {
        List<TicketInfoBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT DISTINCT new vn.edu.fpt.capstone.busReservation.dao.bean.TicketInfoBean(tkt, trps, trpe, SUM(tar.fare))"
                    + " FROM TicketBean tkt"
                    + " INNER JOIN tkt.trips trps"
                    + " INNER JOIN tkt.trips trpe"
                    + " INNER JOIN tkt.trips trp"
                    + " INNER JOIN trp.routeDetails.segment.tariffs tar"
                    + " INNER JOIN tkt.reservation rsv"
                    + " WHERE tkt.id = :ticketId"
                    + "     AND rsv.status != :rsvStatusMoved"
                    + "     AND tkt.status != :ticketStatusMoved"
                    + "     AND trps.departureTime = ("
                    + "         SELECT MIN(trp1.departureTime)"
                    + "         FROM TicketBean tkt1"
                    + "         INNER JOIN tkt1.trips trp1"
                    + "         WHERE tkt1 = tkt)"
                    + "     AND trpe.departureTime = ("
                    + "         SELECT MAX(trp2.departureTime)"
                    + "         FROM TicketBean tkt2"
                    + "         INNER JOIN tkt2.trips trp2"
                    + "         WHERE tkt2 = tkt)"
                    + "     AND tar.busType = trp.busStatus.bus.busType"
                    + "     AND tar.validFrom = ("
                    + "         SELECT MAX(tar.validFrom)"
                    + "         FROM TariffBean tar1"
                    + "         WHERE tar1.segment = trp.routeDetails.segment"
                    + "             AND tar1.busType = trp.busStatus.bus.busType"
                    + "             AND tar1.validFrom <= rsv.bookTime)"
                    + " GROUP BY tkt,trps,trps.busStatus,trps.departureTime,trpe"
                    + " ORDER BY trps.departureTime";
            query = session.createQuery(queryString);
            query.setInteger("ticketId", ticketId);
            query.setString("rsvStatusMoved",
                    ReservationStatus.MOVED.getValue());
            query.setString("ticketStatusMoved", TicketStatus.MOVED.getValue());
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result == null || result.size() <= 0 ? null : result.get(0);
    }

    /**
     * @param reservationId
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<TicketInfoBean> getTicketInfoByReservationId(int reservationId) {
        List<TicketInfoBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT DISTINCT tkt, trps, trpe, SUM(tar.fare)"
                    + " FROM TicketBean tkt"
                    + " INNER JOIN tkt.trips trps"
                    + " INNER JOIN tkt.trips trpe"
                    + " INNER JOIN tkt.trips trp"
                    + " INNER JOIN trp.routeDetails.segment.tariffs tar"
                    + " INNER JOIN tkt.reservation rsv"
                    + " WHERE rsv.id = :reservationId"
                    + "     AND rsv.status != :rsvStatusMoved"
                    + "     AND tkt.status != :ticketStatusMoved"
                    + "     AND trps.departureTime = ("
                    + "         SELECT MIN(trp1.departureTime)"
                    + "         FROM TicketBean tkt1"
                    + "         INNER JOIN tkt1.trips trp1"
                    + "         WHERE tkt1 = tkt)"
                    + "     AND trpe.departureTime = ("
                    + "         SELECT MAX(trp2.departureTime)"
                    + "         FROM TicketBean tkt2"
                    + "         INNER JOIN tkt2.trips trp2"
                    + "         WHERE tkt2 = tkt)"
                    + "     AND tar.busType = trp.busStatus.bus.busType"
                    + "     AND tar.validFrom = ("
                    + "         SELECT MAX(tar.validFrom)"
                    + "         FROM TariffBean tar1"
                    + "         WHERE tar1.segment = trp.routeDetails.segment"
                    + "             AND tar1.busType = trp.busStatus.bus.busType"
                    + "             AND tar1.validFrom <= rsv.bookTime)"
                    + " GROUP BY tkt,trps,trps.busStatus,trps.departureTime,trpe"
                    + " ORDER BY trps.departureTime";
            query = session.createQuery(queryString);
            query.setInteger("reservationId", reservationId);
            query.setString("rsvStatusMoved",
                    ReservationStatus.MOVED.getValue());
            query.setString("ticketStatusMoved", TicketStatus.MOVED.getValue());
            query.setResultTransformer(TICKET_INFO_BEAN_TRANSFORMER);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    /**
     * Get paid ticket for a bus status
     * 
     * @param busStatusId
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<TicketInfoBean> getCancelledTicketInfos(int busStatusId) {
        List<TicketInfoBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT DISTINCT tkt, trps, trpe, SUM(tar.fare)"
                    + " FROM TicketBean tkt"
                    + " INNER JOIN tkt.trips trps"
                    + " INNER JOIN tkt.trips trpe"
                    + " INNER JOIN tkt.trips trp"
                    + " INNER JOIN trp.routeDetails.segment.tariffs tar"
                    + " INNER JOIN tkt.reservation rsv"
                    + " INNER JOIN trps.busStatus bst"
                    + " WHERE bst.id = :busStatusId"
                    // + "     AND rsv.status = :rsvStatusPaid"
                    + "     AND tkt.status = :ticketStatusCancelled"
                    + "     AND trps.departureTime = ("
                    + "         SELECT MIN(trp1.departureTime)"
                    + "         FROM TicketBean tkt1"
                    + "         INNER JOIN tkt1.trips trp1"
                    + "         WHERE tkt1 = tkt)"
                    + "     AND trpe.departureTime = ("
                    + "         SELECT MAX(trp2.departureTime)"
                    + "         FROM TicketBean tkt2"
                    + "         INNER JOIN tkt2.trips trp2"
                    + "         WHERE tkt2 = tkt)"
                    + "     AND tar.busType = trp.busStatus.bus.busType"
                    + "     AND tar.validFrom = ("
                    + "         SELECT MAX(tar.validFrom)"
                    + "         FROM TariffBean tar1"
                    + "         WHERE tar1.segment = trp.routeDetails.segment"
                    + "             AND tar1.busType = trp.busStatus.bus.busType"
                    + "             AND tar1.validFrom <= rsv.bookTime)"
                    + " GROUP BY tkt,trps,trps.busStatus,trps.departureTime,trpe"
                    + " ORDER BY trps.departureTime";
            query = session.createQuery(queryString);
            query.setInteger("busStatusId", busStatusId);
            // query.setString("rsvStatusPaid",
            // ReservationStatus.PAID.getValue());
            query.setString("ticketStatusCancelled",
                    TicketStatus.CANCELLED.getValue());
            query.setResultTransformer(TICKET_INFO_BEAN_TRANSFORMER);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    @SuppressWarnings("unchecked")
    public String getChangeReason(int ticketId, int changeTypeId) {
        List<String> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT change.reason FROM TicketBean ticket INNER JOIN ticket.trips trip INNER JOIN trip.busStatus.changes change INNER JOIN change.type changeType WHERE ticket.id = :ticketId AND changeType.id = :changeTypeId ORDER BY change.date DESC";
            query = session.createQuery(queryString);
            query.setInteger("ticketId", ticketId);
            query.setInteger("changeTypeId", changeTypeId);
            query.setMaxResults(1);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result == null || result.size() <= 0 ? "" : result.get(0);
    }

}
