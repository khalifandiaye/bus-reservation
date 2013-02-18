/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.TripWithNumberOfRemainedSeatsInSubrouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripWithNumberOfRemainedSeatsInSubrouteKey;

/**
 * @author Yoshimi
 * 
 */
public class TripWithNumberOfRemainedSeatsInSubrouteDAO
        extends
        GenericDAO<TripWithNumberOfRemainedSeatsInSubrouteKey, TripWithNumberOfRemainedSeatsInSubrouteBean> {

    public TripWithNumberOfRemainedSeatsInSubrouteDAO(
            Class<TripWithNumberOfRemainedSeatsInSubrouteBean> clazz) {
        super(clazz);
    }

    @SuppressWarnings("unchecked")
    public List<TripWithNumberOfRemainedSeatsInSubrouteBean> getAvailableTrips(
            int startCityId, int endCityId, int numberOfNeededSeats) {
        List<TripWithNumberOfRemainedSeatsInSubrouteBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT t FROM TripWithNumberOfRemainedSeatsInSubrouteBean AS t WHERE t.startCity.id = :startCityId AND t.endCity.id = :endCityId AND numberOfRemainedSeats >= :numberOfNeededSeats";
            query = session.createQuery(queryString);
            query.setInteger("startCityId", startCityId);
            query.setInteger("endCityId", endCityId);
            query.setInteger("numberOfNeededSeats", numberOfNeededSeats);
            result = query.list();
            // commit transaction
            // session.getTransaction().commit();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

}
