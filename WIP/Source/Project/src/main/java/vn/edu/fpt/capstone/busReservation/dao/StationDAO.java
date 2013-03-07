/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;

/**
 * @author Yoshimi
 * 
 */
public class StationDAO extends GenericDAO<Integer, StationBean> {

	public StationDAO(Class<StationBean> clazz) {
		super(clazz);
	}

	@SuppressWarnings("unchecked")
	public List<StationBean> getStationsByCity(int cityId) {
		List<StationBean> result = new ArrayList<StationBean>();
		Query query = null;
		String queryString = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		Transaction tx = session.beginTransaction();
		try {
			queryString = "FROM StationBean st WHERE st.city.id = :cityId";
			query = session.createQuery(queryString);
			query.setParameter("cityId", cityId);
			result = query.list();
			tx.commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		// return result, if needed
		return result;
	}
}
