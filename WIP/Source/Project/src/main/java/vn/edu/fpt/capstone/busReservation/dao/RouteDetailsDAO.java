package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

public class RouteDetailsDAO extends GenericDAO<Integer, RouteDetailsBean>{

	public RouteDetailsDAO(Class<RouteDetailsBean> clazz) {
		super(clazz);
		// TODO Auto-generated constructor stub
	}
	
	@SuppressWarnings("unchecked")
	public List<SegmentBean> getAllSegmemtsByRouteId(int routeId) {
		String hql = "from RouteDetailsBean sir where sir.route.id = :routeId";
		Session session = sessionFactory.getCurrentSession();
		List<SegmentBean> result = new ArrayList<SegmentBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("routeId", routeId);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}

		return result;
	}
}