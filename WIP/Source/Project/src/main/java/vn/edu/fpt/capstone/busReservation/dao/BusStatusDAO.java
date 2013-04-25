/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.ResultTransformer;

import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusChangeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusChangeTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean.TicketStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;
import vn.edu.fpt.capstone.busReservation.displayModel.BusStatus;

/**
 * @author Yoshimi
 * 
 */
public class BusStatusDAO extends GenericDAO<Integer, BusStatusBean> {

    private static class BusStatusInfoTransformer implements ResultTransformer {

        /**
         * 
         */
        private static final long serialVersionUID = 1L;
        private final boolean last;
        private final Date date;

        /**
         * @param last
         * @param date
         */
        public BusStatusInfoTransformer(boolean last, Date date) {
            this.last = last;
            this.date = date;
        }

        @Override
        public Object transformTuple(Object[] tuple, String[] aliases) {
            if (!last
                    && (date != null && tuple[6] != null && date
                            .before((Date) tuple[6]))) {
                return tuple == null ? null : new BusStatus((Integer) tuple[0],
                        (String) tuple[1], (String) tuple[2],
                        (Integer) tuple[3], (Integer) tuple[4], null, null,
                        null, null);
            } else {
                return tuple == null ? null : new BusStatus((Integer) tuple[0],
                        (String) tuple[1], (String) tuple[2],
                        (Integer) tuple[3], (Integer) tuple[4],
                        (String) tuple[5], (Date) tuple[7], (String) tuple[8],
                        (String) tuple[9]);
            }
        }

        @SuppressWarnings("rawtypes")
        @Override
        public List transformList(List collection) {
            return collection;
        }

    }

    public BusStatusDAO(Class<BusStatusBean> clazz) {
        super(clazz);
    }

    /**
     * Common database exception handling
     * 
     * @param e
     *            the occurred exception
     * @throws HibernateException
     *             the occurred exception
     */
    @SuppressWarnings("unchecked")
    public List<BusStatusBean> getAllTrip() {
        String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.status = :status "
                + "AND bs.busStatus != :busStatus";
        Session session = sessionFactory.getCurrentSession();
        List<BusStatusBean> result = new ArrayList<BusStatusBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("status", "active");
            query.setParameter("busStatus", "initiation");
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    /**
     * Common database exception handling
     * 
     * @param e
     *            the occurred exception
     * @throws HibernateException
     *             the occurred exception
     */
    @SuppressWarnings("unchecked")
    public List<BusStatusBean> getInitiationTrips(BusBean busBean) {
        String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.bus = :busBean "
                + "AND bs.busStatus == :busStatus ORDER BY bs.fromDate DESC";
        Session session = sessionFactory.getCurrentSession();
        List<BusStatusBean> result = new ArrayList<BusStatusBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("busBean", busBean);
            query.setParameter("busStatus", "initiation");
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    /**
     * Common database exception handling Get all scheduled trip from (toDate)
     * to future that has status is maintain or ontrip
     * 
     * @param e
     *            the occurred exception
     * @throws HibernateException
     *             the occurred exception
     */
    @SuppressWarnings("unchecked")
    public List<BusStatusBean> getAllScheduledTrip(Date fromDate) {
        String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.status = :status "
                + "AND bs.busStatus = :busStatus "
                + "AND bs.fromDate >= :fromDate ORDER BY bs.fromDate ASC";
        Session session = sessionFactory.getCurrentSession();
        List<BusStatusBean> result = new ArrayList<BusStatusBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("status", "active");
            query.setParameter("busStatus", "ontrip");
            query.setParameter("fromDate", fromDate);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    /**
     * Common database exception handling
     * 
     * @param e
     *            the occurred exception
     * @throws HibernateException
     *             the occurred exception
     */
    @SuppressWarnings("unchecked")
    public List<BusStatusBean> getAllAvailTripByRouteId(int routeId, Date date) {
        String hql = "Select distinct bs FROM BusStatusBean bs INNER JOIN FETCH bs.bus bus INNER JOIN FETCH bus.busType INNER JOIN bs.trips trp INNER JOIN trp.routeDetails.route rte WHERE rte.id = :routeId "
                + "AND bs.busStatus = :busStatus "
                + "AND bs.fromDate >= :date AND bs.status = :status "
                + "ORDER BY bs.fromDate ASC";
        Session session = sessionFactory.getCurrentSession();
        List<BusStatusBean> result = new ArrayList<BusStatusBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("routeId", routeId);
            query.setParameter("busStatus", "ontrip");
            query.setParameter("date", date);
            query.setParameter("status", "active");
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    /**
     * Common database exception handling
     * 
     * @param e
     *            the occurred exception
     * @throws HibernateException
     *             the occurred exception
     */
    @SuppressWarnings("unchecked")
    public List<BusStatusBean> getAllTripsByRouteId(int routeId) {
        String hql = "Select distinct bs FROM BusStatusBean bs INNER JOIN bs.trips trp INNER JOIN "
                + "trp.routeDetails.route rte WHERE rte.id = :routeId "
                + "AND bs.busStatus = :busStatus " + "ORDER BY bs.fromDate";
        Session session = sessionFactory.getCurrentSession();
        List<BusStatusBean> result = new ArrayList<BusStatusBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("routeId", routeId);
            query.setParameter("busStatus", "ontrip");
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<BusStatusBean> getAllAvailTripByBusId(int busId, Date date) {
        String hql = "SELECT bs.id FROM BusStatusBean bs WHERE bs.bus.id = :busId "
                + "AND bs.fromDate >= :date AND bs.status = :status AND bs.busStatus != :busStatus";
        Session session = sessionFactory.getCurrentSession();
        List<BusStatusBean> result = new ArrayList<BusStatusBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("busId", busId);
            query.setParameter("date", date);
            query.setParameter("status", "active");
            query.setParameter("busStatus", "initiation");
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    /**
     * Common database exception handling Get all bus status in the future by
     * bus id
     * 
     * @param e
     *            the occurred exception
     * @throws HibernateException
     *             the occurred exception
     */

    @SuppressWarnings("unchecked")
    public List<BusStatusBean> getAllTripByBusId(int busId, Date date) {
        String hql = "SELECT bs.id FROM BusStatusBean bs WHERE bs.bus.id = :busId "
                + "AND bs.toDate >= :date AND bs.status = :status";
        Session session = sessionFactory.getCurrentSession();
        List<BusStatusBean> result = new ArrayList<BusStatusBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("busId", busId);
            query.setParameter("date", date);
            query.setParameter("status", "active");
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    /**
     * Common database exception handling Get all max date to maintain
     * 
     * @param e
     *            the occurred exception
     * @throws HibernateException
     *             the occurred exception
     */
    @SuppressWarnings("unchecked")
    public List<Date> getMaintainFromDate(int busId) {
        String hql = "SELECT MAX(bs.toDate) FROM BusStatusBean bs WHERE bs.status = :status "
                + "AND bs.bus.id = :busId";
        Session session = sessionFactory.getCurrentSession();
        List<Date> result = new ArrayList<Date>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("status", "active");
            query.setParameter("busId", busId);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    /**
     * Common database exception handling Get current station by toDate
     * 
     * @param e
     *            the occurred exception
     * @throws HibernateException
     *             the occurred exception
     */
    @SuppressWarnings("unchecked")
    public List<StationBean> getCurrentStation(Date toDate) {
        String hql = "SELECT bs.endStation FROM BusStatusBean bs WHERE bs.status = :status "
                + "AND bs.toDate = :toDate";
        Session session = sessionFactory.getCurrentSession();
        List<StationBean> result = new ArrayList<StationBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("status", "active");
            query.setParameter("toDate", toDate);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    /**
     * Common database exception handling Get current station by toDate Get last
     * station of bus
     * 
     * @param e
     *            the occurred exception
     * @throws HibernateException
     *             the occurred exception
     */
    @SuppressWarnings("unchecked")
    public List<Object[]> getLastStationByBusId(int busId) {
        String hql = "SELECT bs.endStation, MAX(bs.toDate) FROM BusStatusBean bs WHERE bs.status = :status "
                + "AND bs.bus.id = :busId";
        Session session = sessionFactory.getCurrentSession();
        List<Object[]> result = new ArrayList<Object[]>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("status", "active");
            query.setParameter("busId", busId);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<BusStatusBean> getBusStatus(int routeId, int busId, Date date) {
        String hql = "FROM BusStatusBean bs WHERE bs.endStation.id = :busId "
                + "AND bs.bus.id = :busId";
        Session session = sessionFactory.getCurrentSession();
        List<BusStatusBean> result = new ArrayList<BusStatusBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("status", "active");
            query.setParameter("busId", busId);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    /**
     * Common database exception handling Get exist busStatus(used by add new
     * schedule)
     * 
     * @param e
     *            the occurred exception
     * @throws HibernateException
     *             the occurred exception
     */
    @SuppressWarnings("unchecked")
    public List<BusStatusBean> getDuplicatedBusAndDate(BusBean busBean,
            Date date, StationBean endStation) {
        String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.bus = :busBean AND bs.fromDate = :date "
                + "AND bs.endStation = :endStation "
                + "AND bs.busStatus = :busStatus AND bs.status = :status";
        Session session = sessionFactory.getCurrentSession();
        List<BusStatusBean> result = new ArrayList<BusStatusBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("busBean", busBean);
            query.setParameter("date", date);
            query.setParameter("endStation", endStation);
            query.setParameter("busStatus", "ontrip");
            query.setParameter("status", "inactive");
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<BusStatusBean> getAllScheduledTripByRouteId(int routeId,
            Date fromDate) {
        String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.status = :status "
                + "AND bs.busStatus != :busStatus "
                + "AND bs.fromDate >= :fromDate AND (bs.bus.forwardRoute.id = :routeId "
                + "OR bs.bus.returnRoute.id = :routeId)";
        Session session = sessionFactory.getCurrentSession();
        List<BusStatusBean> result = new ArrayList<BusStatusBean>();
        try {
            // must have to start any transaction
            Query query = session.createQuery(hql);
            query.setParameter("status", "active");
            query.setParameter("busStatus", "initiation");
            query.setParameter("fromDate", fromDate);
            query.setParameter("routeId", routeId);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<TicketBean> getTickets(int busStatusId) {
        List<TicketBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        List<String> stati = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT DISTINCT tkt FROM "
                    + "TicketBean tkt INNER JOIN tkt.trips trp INNER JOIN trp.busStatus bst INNER JOIN FETCH tkt.payments INNER JOIN FETCH tkt.reservation rsv WHERE bst.id = :busStatusId AND tkt.status IN (:statusTicketValidStati) AND rsv.status IN (:statusReservationValidStati)";
            query = session.createQuery(queryString);
            query.setInteger("busStatusId", busStatusId);
            stati = new ArrayList<String>();
            stati.add(TicketStatus.ACTIVE.getValue());
            stati.add(TicketStatus.PENDING.getValue());
            query.setParameterList("statusTicketValidStati", stati);
            stati = new ArrayList<String>();
            stati.add(ReservationStatus.PAID.getValue());
            stati.add(ReservationStatus.PENDING.getValue());
            query.setParameterList("statusReservationValidStati", stati);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public void cancel(int busStatusId, String reason, int userId) {
        Query query = null;
        String queryString = null;
        Session session = null;
        List<String> stati = null;
        BusStatusChangeBean change = null;
        List<Integer> ids = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            // set busStatus to 'cancelled'
            queryString = "UPDATE BusStatusBean bst SET bst.status = 'cancelled' WHERE bst.id = :busStatusId";
            query = session.createQuery(queryString);
            query.setInteger("busStatusId", busStatusId);
            query.executeUpdate();
            // select related tickets
            queryString = "SELECT tkts.id" + " FROM BusStatusBean bst"
                    + " INNER JOIN bst.trips trp"
                    + " INNER JOIN trp.tickets tkts"
                    + " INNER JOIN tkts.reservation rsv"
                    + " WHERE bst.id = :busStatusId"
                    + " AND tkts.status IN (:tktStati)"
                    + " AND rsv.status IN (:rsvStati)";
            query = session.createQuery(queryString);
            query.setInteger("busStatusId", busStatusId);
            stati = new ArrayList<String>();
            stati.add(TicketStatus.ACTIVE.getValue());
            stati.add(TicketStatus.PENDING.getValue());
            query.setParameterList("tktStati", stati);
            stati = new ArrayList<String>();
            stati.add(ReservationStatus.PAID.getValue());
            stati.add(ReservationStatus.PENDING.getValue());
            query.setParameterList("rsvStati", stati);
            ids = query.list();
            // set related tickets to 'cancelled'
            if (ids != null && ids.size() > 0) {
                queryString = "UPDATE TicketBean tkt"
                        + " SET tkt.status = :cancelled"
                        + " WHERE tkt.id IN (:ids)";
                query = session.createQuery(queryString);
                query.setString("cancelled", TicketStatus.CANCELLED.getValue());
                query.setParameterList("ids", ids);
                query.executeUpdate();
            }
            // add status change record
            change = new BusStatusChangeBean();
            change.setBusStatus((BusStatusBean) session.get(
                    BusStatusBean.class, busStatusId));
            change.setDate(new Date());
            change.setReason(reason);
            change.setType((BusStatusChangeTypeBean) session.get(
                    BusStatusChangeTypeBean.class, 1));
            change.setUser((UserBean) session.get(UserBean.class, userId));
            session.save(change);
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
    }

    /**
     * return status of all buses at a specific time, or the last status
     * 
     * @param last
     *            true to get last status, false to get status at a specific
     *            time
     * @param date
     *            time to get status, only when last is false
     * @return status of all buses
     */
    @SuppressWarnings("unchecked")
    public List<BusStatus> getAllBusStatus(boolean last, Date date) {
        List<BusStatus> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        String append = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            if (!last) {
                append = "              AND bsts.fromDate <= :date";
            } else {
                append = "";
            }
            queryString = " SELECT DISTINCT bus.id, bus.plateNumber"
                    + "     , bus.status, rtef.id, rter.id"
                    + "     , bst.busStatus, bst.fromDate, bst.toDate"
                    + "     , stne.name, loce.name FROM BusBean bus"
                    + " LEFT JOIN bus.forwardRoute rtef"
                    + " LEFT JOIN bus.returnRoute rter"
                    + " LEFT JOIN bus.statusList bst"
                    + " LEFT JOIN bst.endStation stne"
                    + " LEFT JOIN stne.city loce WHERE bst = NULL "
                    + "  OR 0 = (SELECT COUNT(*)"
                    + "      FROM BusStatusBean bsts"
                    + "      WHERE bsts.bus = bus"
                    + "          AND bsts.status = :active"
                    + "          AND bsts.busStatus <> :initiation"
                    + append
                    + "      ) OR (bst.fromDate = ("
                    + "          SELECT MAX(bsts.fromDate)"
                    + "          FROM BusStatusBean bsts"
                    + "          WHERE bsts.bus = bus"
                    + "              AND bsts.status = :active"
                    + "              AND bsts.busStatus <> :initiation"
                    + append + ")) GROUP BY bus";
            query = session.createQuery(queryString);
            query.setString("active", "active");
            query.setString("initiation", "initiation");
            if (!last) {
                query.setTimestamp("date", date);
            }
            query.setResultTransformer(new BusStatusInfoTransformer(last, date));
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }
}
