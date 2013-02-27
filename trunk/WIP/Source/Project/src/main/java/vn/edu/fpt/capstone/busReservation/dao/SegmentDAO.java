/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

/**
 * @author Yoshimi
 *
 */
public class SegmentDAO extends GenericDAO<Integer, SegmentBean> {

	public SegmentDAO(Class<SegmentBean> clazz) {
		super(clazz);
	}
	
	public String getTravelTime(int id) {
		String strQuery = "SELECT CAST( sec_to_time(time_to_sec(s.travel_time)) " +
				"AS CHAR CHARACTER SET utf8 ) " +
				"FROM segment s WHERE s.id = :id";
		Session session = sessionFactory.getCurrentSession();
		String result = "";
		try {
			// must have to start any transaction
			Query query = session.createSQLQuery(strQuery);
			query.setParameter("id", id);
			result = (String) query.list().get(0);
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}

		return result;
	}
}
