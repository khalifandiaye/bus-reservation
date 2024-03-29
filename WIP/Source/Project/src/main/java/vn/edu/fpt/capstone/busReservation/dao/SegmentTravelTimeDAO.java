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

import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentTravelTimeBean;

public class SegmentTravelTimeDAO extends
		GenericDAO<Integer, SegmentTravelTimeBean> {

	public SegmentTravelTimeDAO(Class<SegmentTravelTimeBean> clazz) {
		super(clazz);
		// TODO Auto-generated constructor stub
	}

	/**
	 * Search valid travel time of segment<tt>segmentId</tt> in <tt>date</tt>
	 * 
	 * @param segmentId
	 *            segmentId <tt>toStation</tt>
	 * @param date
	 *            valid date <tt>date</tt>
	 * @return 1 valid SegmentTravelTimeBean
	 */
	@SuppressWarnings("unchecked")
	public List<SegmentTravelTimeBean> getTravelTimebyDate(int segmentId,
			Date date) {
		String hql = "SELECT stt FROM SegmentTravelTimeBean stt "
				+ "WHERE stt.segment.id = :segmentId "
				+ "AND stt.validFrom = (SELECT MAX(stt1.validFrom) "
				+ "FROM SegmentTravelTimeBean stt1 "
				+ "WHERE stt1.segment = stt.segment AND stt1.validFrom <= :date) " +
				"ORDER BY stt.validFrom DESC";
		Session session = sessionFactory.getCurrentSession();
		List<SegmentTravelTimeBean> result = new ArrayList<SegmentTravelTimeBean>();
		try {
			Query query = session.createQuery(hql);
			query.setParameter("segmentId", segmentId).setParameter("date", date);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public List<SegmentTravelTimeBean> getExistDuration(int segmentId, Date validDate) {
		List<SegmentTravelTimeBean> result = new ArrayList<SegmentTravelTimeBean>();
		Session session = sessionFactory.getCurrentSession();
		try {
			String queryString = "FROM SegmentTravelTimeBean t WHERE t.segment.id = :segmentId AND " +
					"t.validFrom = :validDate";
			Query query = session.createQuery(queryString);
			query.setParameter("segmentId", segmentId);
			query.setParameter("validDate", validDate);
			result = query.list();
			// commit transaction
			// session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		// return result, if needed
		return result;
	}

}
