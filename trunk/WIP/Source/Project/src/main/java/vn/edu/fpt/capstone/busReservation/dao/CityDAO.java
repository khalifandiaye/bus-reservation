package vn.edu.fpt.capstone.busReservation.dao;

import java.util.Calendar;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;

public class CityDAO extends GenericDAO<Integer, CityBean> {

    public CityDAO(Class<CityBean> clazz) {
        super(clazz);
        // TODO Auto-generated constructor stub
    }

    @SuppressWarnings("unchecked")
    public List<CityBean> getDepartCity() {
        List<CityBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        // Transaction tx = session.beginTransaction();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = " SELECT distinct(trip.routeDetails.segment.startAt.city) "
                    + " FROM TripBean trip "
                    + " WHERE trip.departureTime >= :time "
                    + "   AND trip.busStatus.status = :status ";
            Calendar now = Calendar.getInstance();
            now.add(Calendar.MINUTE, 30);
            query = session.createQuery(queryString).setTimestamp("time", now.getTime())
            										.setString("status", "active");
            result = query.list();
            // commit transaction
            // session.getTransaction().commit();
            // tx.commit();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<CityBean> getArriveCity(int departCityId) {
        List<CityBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        // Transaction tx = session.beginTransaction();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "	SELECT distinct(atrp.routeDetails.segment.endAt.city) "
                    + " FROM TripBean dtrp, TripBean atrp "
                    + " WHERE dtrp.routeDetails.segment.startAt.city.id = :id "
                    + "	  AND dtrp.busStatus = atrp.busStatus "
                    + "	  AND dtrp.departureTime <= atrp.departureTime "
                    + "   AND dtrp.departureTime >= :time " 
                    + "	  AND dtrp.busStatus.status = :status";
            Calendar now = Calendar.getInstance();
            now.add(Calendar.MINUTE, 30);
            query = session.createQuery(queryString)
                    .setInteger("id", departCityId)
                    .setTimestamp("time", now.getTime())
                    .setString("status", "active");
            result = query.list();
            // commit transaction
            // session.getTransaction().commit();
            // tx.commit();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }
}
