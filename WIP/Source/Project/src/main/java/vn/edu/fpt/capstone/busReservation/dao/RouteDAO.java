package vn.edu.fpt.capstone.busReservation.dao;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

public class RouteDAO extends GenericDAO<Integer, RouteBean>{

	public RouteDAO(Class<RouteBean> clazz) {
		super(clazz);
	}
	
	public String getAllSegmentByRouteId(int routeId) {
		String hql = "select SEC_TO_TIME(SUM(TIME_TO_SEC(sir.segment.travelTime))) from RouteDetailsBean sir where sir.route.id = :id";
		Session session = sessionFactory.getCurrentSession();
		String result = "";
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("id", routeId);
			result = query.list().get(0).toString();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		
		return result;
	}
}
