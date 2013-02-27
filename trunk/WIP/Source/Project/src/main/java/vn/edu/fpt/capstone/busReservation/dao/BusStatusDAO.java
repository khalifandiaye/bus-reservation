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
		String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.status = :status AND bs.fromDate != bs.toDate";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
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
