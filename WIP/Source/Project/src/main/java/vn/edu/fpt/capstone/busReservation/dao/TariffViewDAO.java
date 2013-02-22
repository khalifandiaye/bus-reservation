/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.TariffViewBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

/**
 * @author Yoshimi
 * 
 */
public class TariffViewDAO extends GenericDAO<Integer, TariffViewBean> {

    public TariffViewDAO(Class<TariffViewBean> clazz) {
        super(clazz);
    }

    @SuppressWarnings("unchecked")
    public Double getTicketPrice(List<TripBean> trips, Date date) {
        List<Double> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT SUM(tar.fare) FROM TariffViewBean AS tar INNER JOIN tar.segment.routeDetails as rds INNER JOIN rds.trips AS trp INNER JOIN trp.busStatus.bus AS bus WHERE trp IN (:trips) AND tar.busType = bus.busType AND tar.validFrom <= :date AND (tar.validTo > :date OR tar.validTo = null)";
            query = session.createQuery(queryString);
            query.setParameterList("trips", trips);
            query.setTimestamp("date", date);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result == null || result.size() <= 0 ? null : result.get(0);
    }

}
