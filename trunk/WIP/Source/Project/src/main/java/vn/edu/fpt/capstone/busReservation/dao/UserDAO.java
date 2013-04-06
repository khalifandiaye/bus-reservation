package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;

public class UserDAO extends GenericDAO<Integer, UserBean> {

	public UserDAO(Class<UserBean> clazz) {
		super(clazz);
	}
	
	@SuppressWarnings("unchecked")
    public boolean isExist(String username){
		List<UserBean> result = null;
		Query query = null;
		String queryString = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			queryString = "SELECT user FROM UserBean AS user WHERE user.username = ?";
			query = session.createQuery(queryString);
			query.setString(0, username);
			result = query.list();
			// commit transaction
			// session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		// return result, if needed
		if (result.size() > 0) {
			return true;
		}
		return false;
	}
	
	@SuppressWarnings("unchecked")
    public boolean isEmailExist(String email){
		List<UserBean> result = null;
		Query query = null;
		String queryString = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			queryString = "SELECT user FROM UserBean AS user WHERE user.email = ?";
			query = session.createQuery(queryString);
			query.setString(0, email);
			result = query.list();
			// commit transaction
			// session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		// return result, if needed
		if (result.size() > 0) {
			return true;
		}
		return false;
	}

	
	@SuppressWarnings("unchecked")
    public UserBean checkLogin(String username ,String password){
		List<UserBean> result = null;
		Query query = null;
		String queryString = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			queryString = "SELECT user FROM UserBean AS user WHERE user.username = ? AND user.password = ?";
			query = session.createQuery(queryString);
			query.setString(0, username);
			query.setString(1, password);
			result = query.list();
			// commit transaction
			// session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result != null && result.size() > 0 ? result.get(0) : null;
	}

    @SuppressWarnings("unchecked")
    public UserBean getByUsername(String username) {
        List<UserBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT user FROM UserBean AS user WHERE user.username = :username";
            query = session.createQuery(queryString);
            query.setString("username", username);
            result = query.list();
            // commit transaction
            // session.getTransaction().commit();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result != null && result.size() > 0 ? result.get(0) : null;
    }

    @SuppressWarnings("unchecked")
    public UserBean getByEmail(String email) {
        List<UserBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT user FROM UserBean AS user WHERE user.email = :email";
            query = session.createQuery(queryString);
            query.setString("email", email);
            result = query.list();
            // commit transaction
            // session.getTransaction().commit();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result != null && result.size() > 0 ? result.get(0) : null;
    }
    
    @SuppressWarnings("unchecked")
    public List<UserBean> getAllActiveUser() {
        List<UserBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        String[] role = {"Customer","Operator"};
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT user FROM UserBean AS user INNER JOIN user.role AS rol WHERE rol.name IN (:role)";
            query = session.createQuery(queryString); 
            query.setParameterList("role", role);
            result = query.list();
            // commit transaction
            // session.getTransaction().commit();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result != null && result.size() > 0 ? result : null;
    }
}
