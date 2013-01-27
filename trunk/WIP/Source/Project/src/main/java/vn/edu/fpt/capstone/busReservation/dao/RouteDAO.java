package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

public class RouteDAO extends GenericDAO<Integer, RouteBean>{

	public RouteDAO(Class<RouteBean> clazz) {
		super(clazz);
	}
	
	@SuppressWarnings("unchecked")
	public List<SegmentBean> getAllSegmentByRouteId(int routeId) {
		
		String hql = "select sir.segment from RouteDetailsBean sir where sir.route.id = :id";
		Session session = sessionFactory.getCurrentSession();
		List<SegmentBean> result = new ArrayList<SegmentBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("id", routeId);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		
		return result;
	}
}
