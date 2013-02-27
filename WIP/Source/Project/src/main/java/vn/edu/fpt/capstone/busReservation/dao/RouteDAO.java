package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

public class RouteDAO extends GenericDAO<Integer, RouteBean> {

	public RouteDAO(Class<RouteBean> clazz) {
		super(clazz);
	}

	public String getTravelTimeByRouteId(int routeId) {
		String strQuery = "SELECT CAST( sec_to_time( sum( time_to_sec(seg.travel_time))) " +
				"AS CHAR CHARACTER SET utf8 ) " +
				"FROM route_details rd, segment seg " +
				"WHERE rd.segment_id = seg.id " +
				"AND rd.route_id = :id";
		Session session = sessionFactory.getCurrentSession();
		String result = "";
		try {
			// must have to start any transaction
			Query query = session.createSQLQuery(strQuery);
			query.setParameter("id", routeId);
			result = (String) query.list().get(0);
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
	public List<RouteBean> getAllActiveRoute() {
		String hql = "SELECT r FROM RouteBean r WHERE r.status = :status";
		Session session = sessionFactory.getCurrentSession();
		List<RouteBean> result = new ArrayList<RouteBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setString("status", "active");
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
}
