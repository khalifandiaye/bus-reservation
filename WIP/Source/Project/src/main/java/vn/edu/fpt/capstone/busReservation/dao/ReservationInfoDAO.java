package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationInfoBean;

public class ReservationInfoDAO extends
        GenericDAO<ReservationBean, ReservationInfoBean> {

    public ReservationInfoDAO(Class<ReservationInfoBean> clazz) {
        super(clazz);
        // TODO Auto-generated constructor stub
    }

    public ReservationInfoBean getById(int id) {
        ReservationInfoBean result = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            result = new ReservationInfoBean();
            result.setId((ReservationBean) session.get(ReservationBean.class,
                    id));
            result = (ReservationInfoBean) session.get(clazz, result);
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    public ReservationInfoBean loadById(int id) {
        ReservationInfoBean result = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            result = new ReservationInfoBean();
            result.setId((ReservationBean) session.load(ReservationBean.class,
                    id));
            result = (ReservationInfoBean) session.load(clazz, result);
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<ReservationInfoBean> getByUsername(String username) {
        List<ReservationInfoBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT rif FROM ReservationInfoBean AS rif WHERE rif.id.booker.username = ?";
            query = session.createQuery(queryString);
            query.setString(0, username);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    @SuppressWarnings("unchecked")
    public ReservationInfoBean getByCode(String code) {
        List<ReservationInfoBean> result = null;
        Session session = null;
        Query query = null;
        String queryString = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT res FROM ReservationInfoBean AS res WHERE res.id.code = ?";
            query = session.createQuery(queryString);
            query.setString(0, code);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result != null && result.size() > 0 ? result.get(0) : null;
    }

}
