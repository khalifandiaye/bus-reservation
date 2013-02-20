/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

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

}
