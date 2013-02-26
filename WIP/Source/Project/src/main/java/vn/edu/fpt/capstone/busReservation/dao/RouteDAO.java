package vn.edu.fpt.capstone.busReservation.dao;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

public class RouteDAO extends GenericDAO<Integer, RouteBean> {

	public RouteDAO(Class<RouteBean> clazz) {
		super(clazz);
	}

	public Object getTravelTimeByRouteId(int routeId) {
		String strQuery = "select sec_to_time(sum(time_to_sec(segmentbea1_.travel_time))) " +
				"as col_0_0_ from route_details routedetai0_, segment segmentbea1_ " +
				"where routedetai0_.segment_id=segmentbea1_.id " +
				"and routedetai0_.route_id = :id";
		Session session = sessionFactory.getCurrentSession();
		Object result = null;
		try {
			// must have to start any transaction
			Query query = session.createSQLQuery(strQuery);
			query.setParameter("id", routeId);
			result = query.list().get(0);
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}

		return result;
	}
}
