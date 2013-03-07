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

import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;

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
		String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.status = :status AND bs.busStatus != :busStatus";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setString("status", "active");
			query.setString("busStatus", "initiation");
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
		String hql = "SELECT bs.id FROM BusStatusBean bs WHERE bs.bus.forwardRoute.id = :routeId "
				+ "OR  bs.bus.returnRoute.id = :routeId "
				+ "AND bs.busStatus != :busStatus "
				+ "AND bs.fromDate >= :date " + "AND bs.status = :status";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setInteger("routeId", routeId);
			query.setString("busStatus", "initiation");
			query.setDate("date", date);
			query.setString("status", "active");
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<BusStatusBean> getAllAvailTripByBusId(int busId, Date date) {
		String hql = "SELECT bs.id FROM BusStatusBean bs WHERE bs.bus.id = :busId "
				+ "AND bs.fromDate >= :date " + "AND bs.status = :status";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setInteger("busId", busId);
			query.setDate("date", date);
			query.setString("status", "active");
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
}
