package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;

public class ReservationDAO extends GenericDAO<Integer,ReservationBean> {

	public ReservationDAO(Class<ReservationBean> clazz) {
		super(clazz);
	}
	
	@SuppressWarnings("unchecked")
	public ReservationBean getByCode(String code) {
		List<ReservationBean> result = null;
		Query query = null;
		String queryString = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			queryString = "SELECT res FROM ReservationBean AS res WHERE res.code = ?";
			query = session.createQuery(queryString);
			query.setString(0, code);
			result = query.list();
			// commit transaction
			// session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		// return result, if needed
		if (result == null || result.size() <= 0) {
			return null;
		} else {
			return result.get(0);
		}
	}
	
}
