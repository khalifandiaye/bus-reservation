package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchResultInfo;

public class TripDAO extends GenericDAO<Integer, TripBean> {

    public TripDAO(Class<TripBean> clazz) {
	super(clazz);
	// TODO Auto-generated constructor stub
    }

    /**
     * Search all trips going from <tt>fromStation</tt> to <tt>toStation</tt>
     * 
     * @param fromStation
     *            the bus will start or stop this station before <tt>toStation</tt>
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
			int arrvCity, String deptDate, int pssgrNo, int busType) {
		List<SearchResultInfo> returnVal = new ArrayList<SearchResultInfo>();
		Session session = sessionFactory.getCurrentSession();
		//String strQuery = "CALL search_trips(:deptCity, :arrvCity, :deptDate, :pssgrNo, :busType);";
		try {
			//startTransaction();
			 Query query = session.getNamedQuery("callSearchTripsProcedure")
			 .setInteger("deptCity", deptCity)
			 .setInteger("arrvCity", arrvCity)
			 .setString("deptDate", deptDate)
			 .setInteger("pssgrNo", pssgrNo)
			 .setInteger("busType", busType);
			 returnVal = query.list();
/*			Query query = session.createSQLQuery(strQuery)
					.setInteger("deptCity", deptCity)
					.setInteger("arrvCity", arrvCity)
					.setString("deptDate", deptDate)
					.setInteger("pssgrNo", pssgrNo)
					.setInteger("busType", busType);
			List<Object> result = query.list();
			for(int i=0; i<result.size(); i++){
				returnVal.add((SearchResultInfo)result.get(i));
			}*/
			//endTransaction();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return returnVal;
	}
	
	@SuppressWarnings("unchecked")
	public List<TripBean> getBookingTrips(int busStatus, Date deptTime, Date arrTime){
		String hql = "Select trip from TripBean trip " +
				"where tripBean.busStatus.id = :busStatusId " +
				"  and tripBean.departureTime >= deptTime " +
				"  and tripBean.arrivalTime <= arrTime ";
		Session session = sessionFactory.getCurrentSession();
		List<TripBean> result = new ArrayList<TripBean>();
		try {
			Query query = session.createQuery(hql);
			query.setInteger("busStatusId", busStatus)
				 .setDate("deptTime", deptTime)
				 .setDate("arrTime", arrTime);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
}