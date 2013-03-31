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

import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;

/**
 * @author Yoshimi
 * 
 */
public class BusStatusDAO extends GenericDAO<Integer, BusStatusBean> {

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
	 * Get all scheduled trip from (toDate)
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
				+ "AND bs.busStatus != :busStatus " 
				+ "AND bs.fromDate >= :fromDate ORDER BY bs.fromDate ASC";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("status", "active");
			query.setParameter("busStatus", "initiation");
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
		String hql = "Select distinct bs FROM BusStatusBean bs WHERE (bs.bus.forwardRoute.id = :routeId "
				+ "OR  bs.bus.returnRoute.id = :routeId) "
				+ "AND bs.busStatus = :busStatus "
				+ "AND bs.fromDate >= :date AND bs.status != :status";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("routeId", routeId);
			query.setParameter("busStatus", "ontrip");
			query.setParameter("date", date);
			query.setParameter("status", "inactive");
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
	 * Common database exception handling
	 * Get all bus status in the future by bus id
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
	 * Common database exception handling 
	 * Get all max date to maintain
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
	 * Common database exception handling Get current station by toDate
	 * Get last station of bus
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
	 * Common database exception handling
	 * Get exist busStatus(used by add new schedule)
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
   public List<BusStatusBean> getAllScheduledTripByRouteId(int routeId, Date fromDate) {
      String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.status = :status "
            + "AND bs.busStatus != :busStatus " 
            + "AND bs.fromDate >= :fromDate AND (bs.bus.forwardRoute.id = :routeId " +
            "OR bs.bus.returnRoute.id = :routeId)";
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
}
