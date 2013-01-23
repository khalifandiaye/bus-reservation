/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import vn.edu.fpt.capstone.busReservation.dao.GenericDAO;
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
			queryString = "SELECT ta1 FROM TariffBean AS ta1 INNER JOIN ta1.segmentInRoute AS se1, ReservationBean AS res INNER JOIN res.trips AS trp INNER JOIN trp.segmentInRoute AS se2 WHERE res = ? AND se1 = se2 AND ta1.validFrom <= res.bookTime AND ta1.validFrom >= (SELECT MAX(ta2.validFrom) FROM TariffBean ta2 WHERE ta2.segmentInRoute = ta1.segmentInRoute AND ta2.validFrom <= res.bookTime)";
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
