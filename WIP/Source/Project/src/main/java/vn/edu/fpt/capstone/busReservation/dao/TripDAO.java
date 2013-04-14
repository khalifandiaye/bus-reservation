package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.transform.ResultTransformer;

import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchResultInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.TripDetailInfo;

public class TripDAO extends GenericDAO<Integer, TripBean> {

    private static class TripDetailInfoTransformer implements ResultTransformer {

        /**
         * 
         */
        private static final long serialVersionUID = 1L;

        @Override
        public Object transformTuple(Object[] tuple, String[] aliases) {
            // TODO Auto-generated method stub
            return tuple == null ? null : new TripDetailInfo(
                    (Integer) tuple[0], (String) tuple[1], (String) tuple[2],
                    (Date) tuple[3], (Date) tuple[4],
                    ((Long) tuple[5]).intValue());
        }

        @SuppressWarnings("rawtypes")
        @Override
        public List transformList(List collection) {
            // TODO Auto-generated method stub
            return collection;
        }

    }

    public TripDAO(Class<TripBean> clazz) {
        super(clazz);
        // TODO Auto-generated constructor stub
    }

    /**
     * Search all trips going from <tt>fromStation</tt> to <tt>toStation</tt>
     * 
     * @param fromStation
     *            the bus will start or stop this station before
     *            <tt>toStation</tt>
     * @param toStation
     *            the bus will go to this station after <tt>fromStation</tt>
     * @param timeLimit
     *            only count seat in reservation booked from this time onward
     * @param numberOfSeats
     *            number of seats needed to be free during the trip
     * @return list of trips from start station to end station
     */
    @SuppressWarnings("unchecked")
    public List<TripBean> getTrips(String fromStation, String toStation,
            Date timeLimit, int numberOfSeats) {
        List<TripBean> result = null;
        Session session = null;
        String queryString = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            queryString = "SELECT DISTINCT trp FROM TripBean AS trp"
                    + " LEFT JOIN trp.busStatus.trips AS tr1"
                    + " LEFT JOIN trp.busStatus.trips AS tr2"
                    + " LEFT JOIN trp.reservations AS rsv"
                    + " LEFT JOIN rsv.seatPositions AS stp"
                    + " WHERE tr2.routeDetails.segment.endAt.city = :toStation"
                    + " AND tr1.routeDetails.segment.startAt.city = :fromStation"
                    + " AND tr1.departureTime <= tr2.departureTime"
                    + " AND trp.departureTime >= tr1.departureTime"
                    + " AND trp.departureTime <= tr2.departureTime"
                    + " AND rsv.bookTime >= :timeLimit"
                    + " AND trp.statis = :status"
                    + " GROUP BY trp.busStatus, trp.busStatus.bus.busType.numberOfSeats"
                    + " HAVING COUNT(stp.name) < trp.busStatus.bus.busType.numberOfSeats - :numberOfSeats";

            result = session.createQuery(queryString)
                    .setString("fromStation", fromStation)
                    .setString("toStation", toStation)
                    .setTimestamp("timeLimit", timeLimit)
                    .setInteger("numberOfSeats", numberOfSeats)
                    .setString("status", "active").list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<TripBean> getTripsByBusStatus(int busStatusId) {
        String hql = "from TripBean tripBean where tripBean.busStatus.id = :busStatusId";
        Session session = sessionFactory.getCurrentSession();
        List<TripBean> result = new ArrayList<TripBean>();
        try {
            Query query = session.createQuery(hql);
            query.setParameter("busStatusId", busStatusId);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<SearchResultInfo> searchAvailableTrips(int deptCity,
            int arrvCity, String deptDate, int pssgrNo, String minDate) {
        List<SearchResultInfo> returnVal = new ArrayList<SearchResultInfo>();
        Session session = sessionFactory.getCurrentSession();
        // String strQuery =
        // "CALL search_trips(:deptCity, :arrvCity, :deptDate, :pssgrNo, :busType);";
        try {
            // startTransaction();
            Query query = session.getNamedQuery("callSearchTripsProcedure")
                    .setInteger("deptCity", deptCity)
                    .setInteger("arrvCity", arrvCity)
                    .setString("deptDate", deptDate)
                    .setInteger("pssgrNo", pssgrNo)
                    // .setInteger("busType", busType)
                    .setString("minDate", minDate);
            returnVal = query.list();
            /*
             * Query query = session.createSQLQuery(strQuery)
             * .setInteger("deptCity", deptCity) .setInteger("arrvCity",
             * arrvCity) .setString("deptDate", deptDate) .setInteger("pssgrNo",
             * pssgrNo) .setInteger("busType", busType); List<Object> result =
             * query.list(); for(int i=0; i<result.size(); i++){
             * returnVal.add((SearchResultInfo)result.get(i)); }
             */
            // endTransaction();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return returnVal;
    }

    @SuppressWarnings("unchecked")
    public List<TripBean> getBookingTrips(int busStatus, String deptTime,
            String arrTime) {
        String hql = "Select trip from TripBean trip "
                + "where trip.busStatus.id = :busStatusId "
                + "  and trip.departureTime >= :deptTime "
                + "  and trip.arrivalTime <= :arrTime ";
        Session session = sessionFactory.getCurrentSession();
        List<TripBean> result = new ArrayList<TripBean>();
        try {
            Query query = session.createQuery(hql);
            query.setInteger("busStatusId", busStatus)
                    .setString("deptTime", deptTime)
                    .setString("arrTime", arrTime);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<TripBean> getTripDetails(int busStatus, String deptTime,
            String arrTime) {
        String hql = "Select trip from TripBean trip "
                + "	join trip.routeDetails.segment.startAt "
                + "   join trip.routeDetails.segment.endAt "
                + "	join trip.routeDetails.segment.startAt.city "
                + "	join trip.routeDetails.segment.endAt.city "
                + " where trip.busStatus.id = :busStatusId "
                + "  	and trip.departureTime >= :deptTime "
                + "  	and trip.arrivalTime <= :arrTime ";
        Session session = sessionFactory.getCurrentSession();
        List<TripBean> result = new ArrayList<TripBean>();
        try {
            Query query = session.createQuery(hql);
            query.setInteger("busStatusId", busStatus)
                    .setString("deptTime", deptTime)
                    .setString("arrTime", arrTime);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<TripBean> getTripsByRouteAndBus(int routeId, int busType) {
        String hql = "FROM TripBean t WHERE t.routeDetails.route.id = :routeId AND "
                + "t.busStatus.bus.busType = :busType";
        Session session = sessionFactory.getCurrentSession();
        List<TripBean> result = new ArrayList<TripBean>();
        try {
            Query query = session.createQuery(hql);
            query.setParameter("routeId", routeId).setParameter("busType",
                    busType);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    @SuppressWarnings({ "unchecked", "deprecation" })
    public int getMinDuration(int deptCity, int arrvCity) {
        List<Integer> duration = null;
        Session session = sessionFactory.getCurrentSession();
        // String strQuery =
        // "CALL search_trips(:deptCity, :arrvCity, :deptDate, :pssgrNo, :busType);";
        try {
            // startTransaction();
            Query query = session
                    .createSQLQuery(
                            "select min(datediff(arrival_time,departure_time)) as date_diff "
                                    + " from trip_start_end "
                                    + " where start_location_id = :start and end_location_id = :end")
                    .addScalar("date_diff", Hibernate.INTEGER);
            duration = query.setInteger("start", deptCity)
                    .setInteger("end", arrvCity).list();

        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }

        if (duration.size() > 0) {
            return duration.get(0);
        }
        return 0;
    }

    @SuppressWarnings("unchecked")
    public List<SearchResultInfo> getTop4Trips() {
        // String hql =
        // "FROM TripBean tripBean INNER JOIN FETCH tripBean.busStatus INNER JOIN FETCH tripBean.routeDetails INNER JOIN FETCH tripBean.routeDetails.route WHERE tripBean.departureTime > CURRENT_TIMESTAMP() ORDER BY tripBean.departureTime ASC";
        // Session session = sessionFactory.getCurrentSession();
        // List<TripBean> result = new ArrayList<TripBean>();
        // Transaction tx = session.beginTransaction();
        // try {
        // Query query = session.createQuery(hql).setMaxResults(4);
        // result = query.list();
        // tx.commit();
        // } catch (HibernateException e) {
        // exceptionHandling(e, session);
        // }
        // return result;
        List<SearchResultInfo> returnVal = new ArrayList<SearchResultInfo>();
        Session session = sessionFactory.getCurrentSession();
        Transaction tx = session.beginTransaction();
        try {
            // startTransaction();
            Query query = session.getNamedQuery("callGetTop4TripsProcedure");
            returnVal = query.list();
            tx.commit();
            /*
             * Query query = session.createSQLQuery(strQuery)
             * .setInteger("deptCity", deptCity) .setInteger("arrvCity",
             * arrvCity) .setString("deptDate", deptDate) .setInteger("pssgrNo",
             * pssgrNo) .setInteger("busType", busType); List<Object> result =
             * query.list(); for(int i=0; i<result.size(); i++){
             * returnVal.add((SearchResultInfo)result.get(i)); }
             */
            // endTransaction();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return returnVal;
    }

    /**
     * Get information of trips that is going to depart in 24 hours
     * 
     * @param date
     * @param remainedSeatCount
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<TripDetailInfo> getInDateTrips(Date date, int remainedSeatCount) {
        List<TripDetailInfo> result = null;
        Session session = null;
        String queryString = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            queryString = "SELECT DISTINCT bst.id"
                    + "     ,locs.name"
                    + "     ,loce.name"
                    + "     ,trps.departureTime"
                    + "     ,trpe.arrivalTime"
                    + "     ,btp.numberOfSeats - COUNT(DISTINCT stp.name)"
                    + " FROM BusStatusBean bst"
                    + "     INNER JOIN bst.trips trps"
                    + "     INNER JOIN trps.routeDetails.segment.startAt.city locs"
                    + "     INNER JOIN bst.trips trpe"
                    + "     INNER JOIN trpe.routeDetails.segment.endAt.city loce"
                    + "     INNER JOIN bst.trips trp"
                    + "     LEFT JOIN trp.tickets tkt"
                    + "     LEFT JOIN tkt.seatPositions stp"
                    + "     INNER JOIN bst.bus.busType btp"
                    + " WHERE trps.departureTime >= :fromDate"
                    + "     AND trps.departureTime < :toDate"
                    + "     AND trps.departureTime <= trpe.departureTime"
                    + "     AND trp.departureTime >= trps.departureTime"
                    + "     AND trp.departureTime <= trpe.departureTime"
                    + " GROUP BY bst.id"
                    + "     ,locs.name"
                    + "     ,loce.name"
                    + "     ,trps.departureTime"
                    + "     ,trpe.arrivalTime"
                    + "     ,btp.numberOfSeats"
                    + " HAVING btp.numberOfSeats - COUNT(DISTINCT stp.name) >= :remainedSeatCount";
            result = session.createQuery(queryString)
                    // from specified date
                    .setDate("fromDate", date)
                    // to the next 24 hours
                    .setDate("toDate", new Date(date.getTime() + 86400000))
                    // with number of remained seats greater specified number
                    .setInteger("remainedSeatCount", remainedSeatCount)
                    // transform each tuple to TripDetailInfo
                    .setResultTransformer(new TripDetailInfoTransformer())
                    .list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }
}
