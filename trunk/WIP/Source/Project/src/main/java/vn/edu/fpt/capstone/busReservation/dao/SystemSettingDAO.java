/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import vn.edu.fpt.capstone.busReservation.dao.bean.SystemSettingBean;

/**
 * @author Yoshimi
 * 
 */
public class SystemSettingDAO extends GenericDAO<String, SystemSettingBean> {

    public SystemSettingDAO(Class<SystemSettingBean> clazz) {
        super(clazz);
        // TODO Auto-generated constructor stub
    }

    @SuppressWarnings("unchecked")
    public List<SystemSettingBean> getAllLike(String value) {
        List<SystemSettingBean> list = null;
        Session session = null;
        Criteria criteria = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            criteria = session.createCriteria(clazz).add(
                    Restrictions.like("id", value));
            list = criteria.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return list;
    }

    @SuppressWarnings("unchecked")
    public Integer getReservationLockTime() {
        List<Integer> list = null;
        Session session = null;
        String queryString = null;
        Query query = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT CAST(ss.value AS integer) FROM SystemSettingBean ss WHERE ss.id LIKE :pattern ORDER BY ss.id DESC";
            query = session.createQuery(queryString);
            query.setString("pattern", "refund%time");
            query.setMaxResults(1);
            list = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return list == null || list.size() <= 0 ? null : list.get(0);
    }
    
    @SuppressWarnings("unchecked")
    public Integer getStationDelayTime() {
        List<Integer> list = null;
        Session session = null;
        String queryString = null;
        Query query = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT CAST(ss.value AS integer) FROM SystemSettingBean ss WHERE ss.id LIKE :pattern";
            query = session.createQuery(queryString);
            query.setString("pattern", "%station%delay%");
            list = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return list == null || list.size() <= 0 ? null : list.get(0);
    }
    
    @SuppressWarnings("unchecked")
    public Integer getSegmentDefaultPrice() {
        List<Integer> list = null;
        Session session = null;
        String queryString = null;
        Query query = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT CAST(ss.value AS integer) FROM SystemSettingBean ss WHERE ss.id LIKE :pattern";
            query = session.createQuery(queryString);
            query.setString("pattern", "%segment%default%price%");
            list = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return list == null || list.size() <= 0 ? null : list.get(0);
    }
    
    @SuppressWarnings("unchecked")
    public Integer getMaxSeatNumber() {
        List<Integer> list = null;
        Session session = null;
        String queryString = null;
        Query query = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT CAST(ss.value AS integer) FROM SystemSettingBean ss WHERE ss.id LIKE :pattern";
            query = session.createQuery(queryString);
            query.setString("pattern", "%reservation%maxSeat%");
            list = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return list == null || list.size() <= 0 ? null : list.get(0);
    }

}
