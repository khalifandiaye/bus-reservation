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
	public List<SegmentBean> getAllSegmentByRouteId(int routeId) {
		
		String hql = "select sir.SegmentBean from SegmentInRouteBean sir where sir.RouteBean.id = :id";
		Session session = sessionFactory.getCurrentSession();
		List<SegmentBean> result = new ArrayList<SegmentBean>();
		try {
			// must have to start any transaction
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setParameter("id", routeId);
			result = query.list();
			session.close();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		
		return result;
	}
}
