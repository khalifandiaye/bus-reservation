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

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;

/**
 * @author Yoshimi
 * 
 */
public class TariffDAO extends GenericDAO<Integer, TariffBean> {

	public TariffDAO(Class<TariffBean> clazz) {
		super(clazz);
	}

	@SuppressWarnings("unchecked")
	public List<TariffBean> getFares(ReservationBean reservationBean) {
		List<TariffBean> result = null;
		Query query = null;
		String queryString = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			queryString = "SELECT ta1 FROM TariffBean AS ta1 INNER JOIN ta1.segment.routeDetails AS rds INNER JOIN rds.trips AS trp INNER JOIN trp.reservations AS res WHERE res = ? AND ta1.validFrom <= res.bookTime AND ta1.validFrom >= (SELECT MAX(ta2.validFrom) FROM TariffBean ta2 WHERE ta2.segment = ta1.segment AND ta2.validFrom <= res.bookTime)";
			query = session.createQuery(queryString);
			query.setEntity(0, reservationBean);
			result = query.list();
			// commit transaction
			// session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		// return result, if needed
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<Double> getCurrentFares(int segmentId, int busTypeId,
			Date validDate) {
		List<Double> result = null;
		// get the current session
		Session session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			String queryString = "SELECT tr.fare FROM ("
					+ "SELECT * FROM bus_reservation.tariff "
					+ "WHERE segment_id = :segmentId AND bus_type_id = :busTypeId AND valid_from <= :validDate) as tr";
			Query query = session.createSQLQuery(queryString);
			query.setParameter("segmentId", segmentId);
			query.setParameter("busTypeId", busTypeId);
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
	
	@SuppressWarnings("unchecked")
	public List<TariffBean> getExistTariff(int segmentId, int busTypeId,
			Date validDate) {
		List<TariffBean> result = null;
		// get the current session
		Session session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			String queryString = "SELECT tr.id, tr.segment_id, MAX(tr.valid_from) FROM ("
					+ "SELECT * FROM bus_reservation.tariff "
					+ "WHERE segment_id = :segmentId AND bus_type_id = :busTypeId AND valid_from = :validDate) as tr";
			Query query = session.createSQLQuery(queryString);
			query.setParameter("segmentId", segmentId);
			query.setParameter("busTypeId", busTypeId);
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

	@SuppressWarnings("unchecked")
	public List<TariffBean> getPrice(int segmentId, int busTypeId) {
		List<TariffBean> result = new ArrayList<TariffBean>();
		Session session = sessionFactory.getCurrentSession();
		try {
			String queryString = "FROM TariffBean t WHERE t.segment.id = :segmentId AND t.busType.id = :busTypeId";
			Query query = session.createQuery(queryString);
			query.setParameter("segmentId", segmentId);
			query.setParameter("busTypeId", busTypeId);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
}
